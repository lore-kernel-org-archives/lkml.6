Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE68C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A658223D0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A658223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeKMAQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:16:13 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:32747 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729380AbeKMAQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:16:13 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 532C14A254C41;
        Mon, 12 Nov 2018 14:22:40 +0000 (GMT)
Received: from [10.204.65.144] (10.204.65.144) by smtpsuk.huawei.com
 (10.201.108.36) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 12 Nov
 2018 14:22:36 +0000
Subject: Re: [RFC][PATCH 08/12] KEYS: PGP-based public key signature
 verification
To:     David Howells <dhowells@redhat.com>
CC:     <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>
References: <20181112102423.30415-9-roberto.sassu@huawei.com>
 <20181112102423.30415-1-roberto.sassu@huawei.com>
 <19985.1542026635@warthog.procyon.org.uk>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <e55a9f80-d2ea-f28f-06ab-3d99786096c4@huawei.com>
Date:   Mon, 12 Nov 2018 15:22:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <19985.1542026635@warthog.procyon.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.204.65.144]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 1:43 PM, David Howells wrote:
> Roberto Sassu <roberto.sassu@huawei.com> wrote:
> 
>> - switch from session to user keyring (Roberto Sassu)
>> - search user keyring only if no keyring was provided, so that the
>>    trustworthiness of the signature depends on the type of keyring
>>    containing the key used for signature verification (Roberto Sassu)
> 
> Er.  No.  You should search the session keyring.  This may contain a link to
> the user keyring (pam_keyinit emplaces one).

Ok. Unfortunately, I was encountering some issues:
---
[   20.477851] BUG: sleeping function called from invalid context at 
mm/slab.h:421
[   20.486987] in_atomic(): 0, irqs_disabled(): 0, pid: 739, name: keyctl
[   20.497393] 4 locks held by keyctl/739:
[   20.500056]  #0: 00000000bd9d7a18 (key_types_sem){....}, at: 
key_type_lookup+0x16/0x80
[   20.503065]  #1: 000000009f5fc7ec (&type->lock_class){....}, at: 
__key_link_begin+0x3f/0x100
[   20.506062]  #2: 00000000cc8bdc61 (key_construction_mutex){....}, at: 
__key_instantiate_and_link+0x30/0x150
[   20.509335]  #3: 000000001dff342f (rcu_read_lock){....}, at: 
pgp_verify_sig+0x57e/0x6a0
[   20.511998] Preemption disabled at:
[   20.512015] [<ffffffff818bc86f>] __mutex_lock+0x5f/0x940
[   20.514885] CPU: 7 PID: 739 Comm: keyctl Not tainted 4.20.0-rc2+ #1138
[   20.516911] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.10.2-1ubuntu1 04/01/2014
[   20.519577] Call Trace:
[   20.520384]  dump_stack+0x5c/0x7b
[   20.521423]  ? __mutex_lock+0x5f/0x940
[   20.523296]  ___might_sleep+0x12f/0x180
[   20.524458]  __kmalloc+0x24c/0x300
[   20.525505]  ? asymmetric_key_hex_to_key_id.part.8+0x30/0x80
[   20.527181]  ? keyring_search_aux+0xbb/0xf0
[   20.528430]  asymmetric_key_hex_to_key_id.part.8+0x30/0x80
[   20.530025]  ? asymmetric_key_id_partial+0x40/0x40
[   20.531422]  asymmetric_key_match_preparse+0x6b/0x90
[   20.532868]  keyring_search+0x79/0xd0
[   20.533938]  ? keyring_alloc+0x80/0x80
[   20.535068]  pgp_verify_sig+0x5d1/0x6a0
[   20.536212]  ? pgp_verify_sig+0x57e/0x6a0
[   20.537389]  ? pgp_key_parse+0x2a0/0x2a0
[   20.538565]  ? __mutex_lock+0x89/0x940
[   20.539701]  ? pgp_test_instantiate+0xb9/0x150 [pgp_test]
[   20.541276]  pgp_test_instantiate+0xb9/0x150 [pgp_test]
---

> You need to consider what it is that the patch trying to achieve.

I understood that the purpose is to check PGP signatures with built-in
keys or keys provided by the user. Since using the session keyring
caused the issue I reported, I thought it was ok to use the user
keyring.

Just a note: the original patches were relying on KEY_FLAG_TRUSTED to
determine if a key is trusted; now the trustworthiness depends on the
type of keyring passed to pgp_verify_sig(). I removed the additional key
search in the user (session) keyring to prevent that signature
verification is done with a key provided by the user even when the
caller of pgp_verify_sig() expects that a trusted key is used. The
search in the session keyring is done if the caller of pgp_verify_sig()
sets the keyring pointer to NULL.

Roberto


> David
> 

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
