Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A13C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8288F20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OJhRpfBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8288F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeIKGpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:45:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41982 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeIKGpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so17956813edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 18:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvWXYcJDv6BstGX4cE367DyP+ZqAePZ98knAmUdwI7s=;
        b=OJhRpfBPRZXzpeCTabrEhfddHI/EPqUbjN1NsxdtyMOMAYD/se242sbC2PbhKK0S64
         RJsGzPSyp1X012+Dhxm+5rhLB+dI358e1+vJpQCgKF38N3EJDWV1cb8VYjpH/+VwDWyx
         GGY0Col5bMrUBZeav9+ubJBNu+Gs79/Vjhg8nIf7h178w/Rpv+EoFsoI+yEwKP4v9h04
         vKvW6EuuutShSTQzmJRTvPLlz1eLSb2vWy1grFmGUZ90ZmcTv9F20K41+Jb3vgP/S03K
         KiCJpkoeFrjhmFgkAssLD5KfLPm2pe1SCqDRqfCkUbDEGZOnKn7mWD5btEKP8nQ/6vqk
         EgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wvWXYcJDv6BstGX4cE367DyP+ZqAePZ98knAmUdwI7s=;
        b=cZnaLdrCW1lkz/R4bE158hhfPTPyMc3mA+ES/dV8NpyvK5w8wlJ8OAl4ItmbV7EaVO
         8HQ9bgs8cmHxfX583UvXMflr58hu6LdLXI4yVrgZq//H/teVMu68zhDzajyKxsjTZMMj
         nDnJ1ljbkC7tlbTY6fkVW2S1yAC79VRCq5rCRvkpqpnaXBYcdyEHAxwGA5+GceEV4P+M
         eIlxHTwAw6ovd5FL1PONt/l17kiGFCI75C53O84huo2r7N2Q4HhFXpeG6FdMPXFt9lF9
         SiKc6gePu/nqPNckdUlVSWCr4vIQgwl82JEIq00yHAR8b229qG/BC+0SAufhbZVq6stp
         hL9A==
X-Gm-Message-State: APzg51C551nCWVfB2biywnFAtn4sMPjFd5JChkZJ6jaudHZvBqkXU/tQ
        YXoqFBvyt4zftOg1WEO17JvzfERJCz8=
X-Google-Smtp-Source: ANB0VdacePzI8YzSum0aDEy6P2QvvElxSMVNnCgApR2S+OrGxaoWTrE86dXhkdPOQ3W3pCoEXvYZaQ==
X-Received: by 2002:a50:a8a6:: with SMTP id k35-v6mr24938116edc.135.1536630503845;
        Mon, 10 Sep 2018 18:48:23 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x22-v6sm9171002edb.8.2018.09.10.18.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 18:48:22 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Daniel Axtens <dja@axtens.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Neuling <mikey@neuling.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan March <nathan@gt.net>,
        =?UTF-8?q?Pasi=20K=C3=A4rkk=C3=A4inen?= <pasik@iki.fi>,
        Peter Hurley <peter@hurleysoftware.com>,
        "Rong, Chen" <rong.a.chen@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com
Subject: [PATCHv3 0/6] tty: Hold write ldisc sem in tty_reopen()
Date:   Tue, 11 Sep 2018 02:48:15 +0100
Message-Id: <20180911014821.26286-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Three fixes that worth to have in the @stable, as we've hit them on v4.9
stable.

And for linux-next - adding lockdep asserts for line discipline changing
code, verifying that write ldisc sem will be held forthwith.

The last patch is optional and probably, timeout can be dropped for
read_lock(). I'll do it if everyone agrees.

Rong Chen, could you kindly re-run this version to see if the lockup
from v1 still happens? I wasn't able to reproduce it..

Thanks,
Dima

Changes since v2:
- Added reviewed-by tags
- Hopefully, fixed reported by 0-day issue.
- Added optional fix for wait_readers decrement

Changes since v1:
- Added tested-by/reported-by tags
- Dropped 3/4 (locking tty pair for lockdep sake),
  Because of that - not adding lockdep_assert_held() in tty_ldisc_open()
- Added 4/4 cleanup to inc tty->count only on success of
  tty_ldisc_reinit()
- lock ldisc without (5*HZ) timeout in tty_reopen()

v1 link: 
lkml.kernel.org/r/<20180829022353.23568-1-dima@arista.com>

Huuge cc list:
Cc: Daniel Axtens <dja@axtens.net>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Nathan March <nathan@gt.net>
Cc: Pasi Kärkkäinen <pasik@iki.fi>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: "Rong, Chen" <rong.a.chen@intel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
(please, ignore if I Cc'ed you mistakenly)

Dmitry Safonov (6):
  tty: Drop tty->count on tty_reopen() failure
  tty/ldsem: Update waiter->task before waking up reader
  tty: Hold tty_ldisc_lock() during tty_reopen()
  tty/lockdep: Add ldisc_sem asserts
  tty: Simplify tty->count math in tty_reopen()
  tty/ldsem: Decrement wait_readers on timeouted down_read()

 drivers/tty/tty_io.c    | 12 ++++++++----
 drivers/tty/tty_ldisc.c |  5 +++++
 drivers/tty/tty_ldsem.c |  5 ++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.13.6

