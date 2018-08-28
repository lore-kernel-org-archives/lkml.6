Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_HTML_ATTACH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493F2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28ECB2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28ECB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeH1Pey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:34:54 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34727 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbeH1Pey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:34:54 -0400
Received: from keineahnung.molgen.mpg.de (keineahnung.molgen.mpg.de [141.14.17.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CC12F2012BA077;
        Tue, 28 Aug 2018 13:43:31 +0200 (CEST)
Subject: Re: How to debug outliers in `wb_wait_for_completion()` in
 `ksys_sync()`?
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <f3ca4798-0936-6d98-f1de-ce4903d6740b@molgen.mpg.de>
Message-ID: <bf7b90d1-c6f0-b0ce-a78e-91b29f869800@molgen.mpg.de>
Date:   Tue, 28 Aug 2018 13:43:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f3ca4798-0936-6d98-f1de-ce4903d6740b@molgen.mpg.de>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050406050907000606060306"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050406050907000606060306
Content-Type: multipart/mixed;
 boundary="------------E2F89A056A3395058E90884F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E2F89A056A3395058E90884F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


On 08/28/18 07:27, Paul Menzel wrote:

> Using `sleepgraph.py` [1][2] to profile the suspend to RAM (STR)
> times, shows that `ksys_enter` takes a noticeable amount of time.
>=20
> 13 ms on a TUXEDO Book BU1406 with the NVMe device *SAMSUNG
> MZVKW512HMJP-00000*, which is quite good, and over a 60 ms on ASRock
> E350M1 with an SSD SanDisk device.

It=E2=80=99s 109 ms on the ASRock E350M1, which makes up one third of the=

total time to reach ACPI S3.

> Adding `devicefilter: ksys_sync` to `config/suspend-callgraph.cfg`,
> and running `sudo ./sleepgraph.py -config
> config/suspend-callgraph.cfg`, the attached HTML output shows, that
> `iterate_supers` takes 6 to 7 ms twice.
>=20
> =E2=80=A2=C2=A0=C2=A0 `iterate_supers` (6.316 ms @ 388.944557)
> =E2=80=A2=C2=A0=C2=A0 `iterate_supers` (0.201 ms @ 388.950873)
> =E2=80=A2=C2=A0=C2=A0 `iterate_supers` (7.421 ms @ 388.951074)
>=20
> Normally, `sync_inodes_one_sb` only takes microseconds, but once in
> both cases it takes several milliseconds.
>=20
> =E2=80=A2=C2=A0=C2=A0 sync_inodes_one_sb (0.001 ms @ 388.944660)
> =E2=80=A2=C2=A0=C2=A0 sync_inodes_one_sb (5.978 ms @ 388.944665)
> =E2=80=A2=C2=A0=C2=A0 sync_inodes_one_sb (0.001 ms @ 388.950645)
>=20
> Please find an excerpt from the call graph from ftrace below, and
> note the time increase between 388.944751 and 388.950636.
>=20
>> =C2=A0 388.944700 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wb_wait_for_completio=
n() {
>> =C2=A0 388.944701 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _cond_res=
ched() {
>> =C2=A0 388.944701 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E064 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_all_qs();
>> =C2=A0 388.944702 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E664 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } /* _cond_resched */
>> =C2=A0 388.944702 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E067 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 init_wait_entry();
>> =C2=A0 388.944703 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepare_t=
o_wait_event() {
>> =C2=A0 388.944703 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E080 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_lock_irqsave();
>> =C2=A0 388.944704 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E073 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_unlock_irqrestore();
>> =C2=A0 388.944704 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 1=
=2E388 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } /* prepare_to_wait_event */
>> =C2=A0 388.944705 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 schedule(=
) {
>> =C2=A0 388.944705 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E085 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcu_note_context_switch();
>> =C2=A0 388.944706 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E064 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_lock();
>> =C2=A0 388.944707 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E093 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_rq_clock();
>> =C2=A0 388.944708 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 deactivate_task() {
>> =C2=A0 388.944708 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dequeue_task_fair() {
>> =C2=A0 388.944708 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dequeue_entity() {
>> =C2=A0 388.944709 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_curr() {
>> =C2=A0 388.944709 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E095 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 update_min_vruntime();
>> =C2=A0 388.944710 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E126 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cpuacct_charge();
>> =C2=A0 388.944710 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __cgroup_account_cputime=
() {
>> =C2=A0 388.944711 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E055 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cgroup_rstat_updated();
>> =C2=A0 388.944711 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E675 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 } /* __cgroup_account_cputime */
>> =C2=A0 388.944712 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 2=
=2E779 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /=
* update_curr */
>> =C2=A0 388.944712 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E121 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
pdate_load_avg_se();
>> =C2=A0 388.944713 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E118 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
pdate_load_avg_cfs_rq();
>> =C2=A0 388.944713 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E056 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cle=
ar_buddies();
>> =C2=A0 388.944714 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E066 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acc=
ount_entity_dequeue();
>> =C2=A0 388.944714 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E050 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upd=
ate_cfs_group();
>> =C2=A0 388.944715 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 6=
=2E127 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* dequeue_en=
tity */
>> =C2=A0 388.944715 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dequeue_entity() {
>> =C2=A0 388.944715 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_curr() {
>> =C2=A0 388.944716 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E097 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __calc_delta();
>> =C2=A0 388.944716 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E071 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 update_min_vruntime();
>> =C2=A0 388.944717 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 1=
=2E473 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /=
* update_curr */
>> =C2=A0 388.944717 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E142 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
pdate_load_avg_se();
>> =C2=A0 388.944718 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E100 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
pdate_load_avg_cfs_rq();
>> =C2=A0 388.944719 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E069 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cle=
ar_buddies();
>> =C2=A0 388.944719 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E098 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acc=
ount_entity_dequeue();
>> =C2=A0 388.944720 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_cfs_group() {
>> =C2=A0 388.944720 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E110 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 reweight_entity();
>> =C2=A0 388.944721 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E847 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /=
* update_cfs_group */
>> =C2=A0 388.944721 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 6=
=2E197 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* dequeue_en=
tity */
>> =C2=A0 388.944722 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E053 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtick_update()=
;
>> =C2=A0 388.944722 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 1=
4.141 us=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* dequeue_task_fair */
>> =C2=A0 388.944723 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 1=
4.827 us=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* deactivate_task */
>> =C2=A0 388.944723 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pick_next_task_fair() {
>> =C2=A0 388.944723 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 update_blocked_averages() {
>> =C2=A0 388.944724 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E070 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_lock_=
irqsave();
>> =C2=A0 388.944724 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E090 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_rq_clock=
();
>> =C2=A0 388.944725 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E120 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __update_load_a=
vg_cfs_rq();
>> =C2=A0 388.944726 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E162 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __update_load_a=
vg_se();
>> =C2=A0 388.944727 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E090 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __update_load_a=
vg_cfs_rq();
>> =C2=A0 388.944727 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E081 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __update_load_a=
vg_cfs_rq();
>> =C2=A0 388.944728 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 update_rt_rq_load_avg() {
>> =C2=A0 388.944728 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E063 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __a=
ccumulate_pelt_segments();
>> =C2=A0 388.944729 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E785 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* update_rt_=
rq_load_avg */
>> =C2=A0 388.944729 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 update_dl_rq_load_avg() {
>> =C2=A0 388.944730 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E066 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __a=
ccumulate_pelt_segments();
>> =C2=A0 388.944730 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E763 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* update_dl_=
rq_load_avg */
>> =C2=A0 388.944731 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E061 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_unloc=
k_irqrestore();
>> =C2=A0 388.944731 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 7=
=2E452 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* update_blocked_average=
s */
>> =C2=A0 388.944731 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 load_balance() {
>> =C2=A0 388.944732 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 find_busiest_group() {
>> =C2=A0 388.944732 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E100 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upd=
ate_nohz_stats();
>> =C2=A0 388.944733 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E057 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idl=
e_cpu();
>> =C2=A0 388.944734 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E098 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upd=
ate_nohz_stats();
>> =C2=A0 388.944734 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 2=
=2E407 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* find_busie=
st_group */
>> =C2=A0 388.944735 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 3=
=2E120 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* load_balance */
>> =C2=A0 388.944735 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E065 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __msecs_to_jiffies();
>> =C2=A0 388.944736 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 load_balance() {
>> =C2=A0 388.944736 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 find_busiest_group() {
>> =C2=A0 388.944736 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E087 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upd=
ate_nohz_stats();
>> =C2=A0 388.944737 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E063 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idl=
e_cpu();
>> =C2=A0 388.944738 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E086 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upd=
ate_nohz_stats();
>> =C2=A0 388.944739 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E068 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upd=
ate_nohz_stats();
>> =C2=A0 388.944739 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E098 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idl=
e_cpu();
>> =C2=A0 388.944740 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E094 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upd=
ate_nohz_stats();
>> =C2=A0 388.944741 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E065 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 idl=
e_cpu();
>> =C2=A0 388.944741 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 5=
=2E160 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* find_busie=
st_group */
>> =C2=A0 388.944742 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 5=
=2E831 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* load_balance */
>> =C2=A0 388.944742 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E062 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __msecs_to_jiffies();
>> =C2=A0 388.944743 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E065 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_lock();
>> =C2=A0 388.944743 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 2=
0.205 us=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* pick_next_task_fair */
>> =C2=A0 388.944744 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pick_next_task_idle() {
>> =C2=A0 388.944744 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 put_prev_task_fair() {
>> =C2=A0 388.944745 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 put_prev_entity() {
>> =C2=A0 388.944745 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E064 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 che=
ck_cfs_rq_runtime();
>> =C2=A0 388.944746 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E713 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* put_prev_e=
ntity */
>> =C2=A0 388.944746 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 put_prev_entity() {
>> =C2=A0 388.944746 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E068 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 che=
ck_cfs_rq_runtime();
>> =C2=A0 388.944747 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E691 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* put_prev_e=
ntity */
>> =C2=A0 388.944747 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 2=
=2E633 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* put_prev_task_fair */
>> =C2=A0 388.944748 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E094 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __update_idle_core();
>> =C2=A0 388.944748 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 3=
=2E899 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* pick_next_task_idle */
>> =C2=A0 388.944749 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 enter_lazy_tlb() {
>> =C2=A0 388.944749 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 switch_mm() {
>> =C2=A0 388.944749 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 switch_mm_irqs_off() {
>> =C2=A0 388.944750 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E244 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loa=
d_new_mm_cr3();
>> =C2=A0 388.944751 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E955 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* switch_mm_=
irqs_off */
>> =C2=A0 388.944751 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 1=
=2E472 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* switch_mm */
>> =C2=A0 388.944751 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 2=
=2E023 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* enter_lazy_tlb */
>> =C2=A0 388.950636 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E103 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finish_task_switch();
>> =C2=A0 388.950638 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 5=
932.632 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } /* schedule */
>> =C2=A0 388.950638 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prepare_t=
o_wait_event() {
>> =C2=A0 388.950638 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E068 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_lock_irqsave();
>> =C2=A0 388.950638 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E053 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_unlock_irqrestore();
>> =C2=A0 388.950639 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E866 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } /* prepare_to_wait_event */
>> =C2=A0 388.950639 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 finish_wa=
it() {
>> =C2=A0 388.950639 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E046 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_lock_irqsave();
>> =C2=A0 388.950640 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E052 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _raw_spin_unlock_irqrestore();
>> =C2=A0 388.950640 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 0=
=2E788 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } /* finish_wait */
>> =C2=A0 388.950640 |=C2=A0=C2=A0 0) sleepgr-11355=C2=A0 |=C2=A0=C2=A0 5=
939.443 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } /* w=
b_wait_for_completion */
>=20
> Can these outliers be avoided? As this is in `schedule`, is it
> related to the used scheduler? At least the Intel Skylake i7-7500U
> CPU @ 2.70GHz processor with four threads in the TUXEDO laptop should
> have enough performance.
>=20
> No scheduler seems to be used for the NVMe device.
>=20
> =C2=A0=C2=A0=C2=A0 $ more /sys/devices/pci0000:00/0000:00:1d.0/0000:04:=
00.0/nvme/nvme0/nvme0n1/queue/scheduler
> =C2=A0=C2=A0=C2=A0 [none]

Please find the data for the SSD SanDisk device (AHCI) attached. Here
is an excerpt.

iterate_supers (53.363 ms @ 921.357477)
    sync_inodes_one_sb (52.417 ms @ 921.357858)
        sync_inodes_sb (52.414 ms @ 921.357859)
            [=E2=80=A6]
            wb_wait_for_completion (17.226 ms @ 921.358335)
            [=E2=80=A6]
        [=E2=80=A6]
        filemap_fdatawait_keep_errors (34.120 ms @ 921.375575)
            __filemap_fdatawait_range (34.117 ms @ 921.375576)
                [=E2=80=A6]
                io_schedule (33.307 ms @ 921.375586)
                [=E2=80=A6]
        [=E2=80=A6]


Kind regards,

Paul


> [1]: https://01.org/suspendresume
> [2]: https://github.com/01org/pm-graph

--------------E2F89A056A3395058E90884F
Content-Type: application/x-7z-compressed;
 name="kodi_mem.html.7z"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="kodi_mem.html.7z"

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
AAAUCgEAgL1qPtg91AEVBgEAIICkgQAA
--------------E2F89A056A3395058E90884F--

--------------ms050406050907000606060306
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xODA4MjgxMTQzMzFaMC8GCSqGSIb3DQEJBDEiBCCsyhLPe3dsMieETF9A
T8fiXavLwlPWJYLkX1EaPIFb1TBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAEgg
PFuc5tW0yecQQLLDV8R8pbdDqqp4C1ymIW0vFqwcHHzRvJT43TpPhtkvcZq+fkOhol0G/R2v
Eugp2JYG2ckCHwMlXcCP395aXELILljx8NN/kIOswF1fw9OukKyyH8N/2Hp3jI2VQP0lxL3Y
IDPK8ih74CLW5BQUv7219Ah1/RT8KhSmF5UYQeCg8otLJbOHrFmsE2YsLmTPOy2J0+qgnhsr
2UkhaPJ0aQalwrHU8Dn9gHO8d6HN6MggzhUkcXVnKcpkaR4+fCHECQCgkeVf7ai7XG8vE9wJ
kJOL7C84R5/g5bQJP9N2b2+qYMs5m+5ZhKwaVhJcaGJ2Deuz1rQAAAAAAAA=
--------------ms050406050907000606060306--
