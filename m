Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbeDAKiW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 06:38:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50914 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753390AbeDAKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 06:38:21 -0400
To: casey@schaufler-ca.com, sargun@sargun.me
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, igor.stoppa@huawei.com, jmorris@namei.org,
        sds@tycho.nsa.gov, paul@paul-moore.com, plautrba@redhat.com
Subject: Re: [PATCH v3 1/1] security: Add mechanism to safely (un)load LSMs after boot time
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <cover.1522357211.git.sargun@sargun.me>
        <5240a81494bbe5be5651379cd9828bda34d764e2.1522357211.git.sargun@sargun.me>
        <3292bbb3-7c9d-f18d-05f3-9b69b3cac922@schaufler-ca.com>
        <20180330023331.GA10833@ircssh-2.c.rugged-nimbus-611.internal>
        <8b015e9e-dccb-aefd-f5b2-c66eed3c6815@schaufler-ca.com>
In-Reply-To: <8b015e9e-dccb-aefd-f5b2-c66eed3c6815@schaufler-ca.com>
Message-Id: <201804011937.HID26097.FFOQOtSJLFMVHO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 1 Apr 2018 19:37:56 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * With writable hooks, we setup a structure like this:
> + * +------+   +-----------+   +-----------+   +-----------+   +--------------+
> + * |      |   |           |   |           |   |           |   |              |
> + * | HEAD +---> Immutable +---> Immutable +---> Null hook +---> Mutable Hook |
> + * |      |   |  Hook 1   |   |  Hook 2   |   |           |   |              |
> + * +------+   +-----------+   +-----------+   +-----------+   +--------------+
> + *                  |               |                                |
> + *                  v               v                                v
> + *              Callback        Callback                         Callback
> + *
> + * The hooks before to null hook are marked only after kernel initialization.
> + * The null hook, as well as the hooks succeeding it are not marked read only,
> + * therefore allowing them be (un)loaded after initialization time.
> + *
> + * Since the null hook doesn't have a callback, we need to check if a hook
> + * is the null hook prior to invoking it.
> + */

Do we need to use null hook as hook == NULL?
Why not overwrite null hook's hook field?

#define call_void_hook(FUNC, ...)                               		\
	do {                                                    		\
		struct security_hook_list *P;                   		\
		int srcu_idx = lock_lsm();					\
		for (P = &security_hook_heads.FUNC; P->hook.FUNC; P = P->next)	\
			P->hook.FUNC(__VA_ARGS__);				\
		unlock_lsm(srcu_idx);
	} while (0)

"struct hlist_head security_hook_heads[SECURITY_HOOK_COUNT]" is marked as __ro_after_init.
Built-in LSM module's "struct security_hook_list[]" is also marked as __ro_after_init.
Dynamic LSM module's "struct security_hook_list[]" is not marked as __initdata.

Hook registration function appends to tail of security_hook_heads.FUNC.
But, before __ro_after_init is applied, initial
"struct security_hook_list dynamic_hook_list[SECURITY_HOOK_COUNT]" is appended to
tail of security_hook_heads. That is, only "struct security_hook_list" at
initial dynamic_hook_list[] and later are writable.

Dynamic hook registration function overwrites current dynamic_hook_list[] with
supplied dynamic module's "struct security_hook_list[]". Then, dynamic hook
registration function allocates memory for next dynamic_hook_list[] and
appends to tail of security_hook_heads.FUNC (note that the tail element is
writable because it is guaranteed to be initial dynamic_hook_list[] or later.



Before registering first built-in immutable LSM module.

    r/w
 * +------+
 * |      |
 * | HEAD +
 * |      |
 * +------+
 *
 *
 *

Before registering second built-in immutable LSM module.

    r/w        r/w
 * +------+   +-----------+
 * |      |   |           |
 * | HEAD +---> Immutable +
 * |      |   |  Hook 1   |
 * +------+   +-----------+
 *                  |
 *                  v
 *              Callback

Before registering initial dynamic_hook_list[].

    r/w        r/w             r/w
 * +------+   +-----------+   +-----------+
 * |      |   |           |   |           |
 * | HEAD +---> Immutable +---> Immutable +
 * |      |   |  Hook 1   |   |  Hook 2   |
 * +------+   +-----------+   +-----------+
 *                  |               |
 *                  v               v
 *              Callback        Callback

After registering initial dynamic_hook_list[] and applying __ro_after_init.

    r/o        r/o             r/o             r/w
 * +------+   +-----------+   +-----------+   +----------------+
 * |      |   |           |   |           |   |                |
 * | HEAD +---> Immutable +---> Immutable +---> Hook for first +
 * |      |   |  Hook 1   |   |  Hook 2   |   | Mutable Module |
 * +------+   +-----------+   +-----------+   +----------------+
 *                  |               |
 *                  v               v
 *              Callback        Callback

After registering first mutable LSM module.

    r/o        r/o             r/o             r/w             r/w
 * +------+   +-----------+   +-----------+   +-----------+   +-----------------+
 * |      |   |           |   |           |   |           |   |                 |
 * | HEAD +---> Immutable +---> Immutable +---> Mutable   +---> Hook for second +
 * |      |   |  Hook 1   |   |  Hook 2   |   |  Hook 1   |   | Mutable Module  |
 * +------+   +-----------+   +-----------+   +-----------+   +-----------------+
 *                  |               |             |
 *                  v               v             v
 *              Callback        Callback      Callback

After registering second mutable LSM module.

    r/o        r/o             r/o             r/w             r/w             r/w
 * +------+   +-----------+   +-----------+   +-----------+   +-----------+   +-----------------+
 * |      |   |           |   |           |   |           |   |           |   |                 |
 * | HEAD +---> Immutable +---> Immutable +---> Mutable   +---> Mutable   +---> Hook for third  +
 * |      |   |  Hook 1   |   |  Hook 2   |   |  Hook 1   |   |  Hook 2   |   | Mutable Module  |
 * +------+   +-----------+   +-----------+   +-----------+   +-----------+   +-----------------+
 *                  |               |             |
 *                  v               v             v
 *              Callback        Callback      Callback

After protectable memory is accepted, all r/w above except the last one will be
marked as r/o by allocating "Hook for X'th Mutable Module" using that allocator.
