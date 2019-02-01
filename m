Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B64AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C40218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dr4atOwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbfBAOM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:12:27 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:12196 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfBAOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:12:25 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190201141222epoutp02692899301a424c262cb56d9080edd3d8~-QuOmGDLo0059700597epoutp02H
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 14:12:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190201141222epoutp02692899301a424c262cb56d9080edd3d8~-QuOmGDLo0059700597epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549030342;
        bh=UKPWsIe65AXfvG62MP1zxfr5DSe60oY/AdxSvb5f9JA=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=Dr4atOwAUqf6TEwy6Qly1zrKY1wZ6ywY+GBq783EHdWaweWh13dFKjxSCWx/5RY0W
         ReloJdgD99SdWlFr9Mwh0ZjU6yp1yfkUDiNIE23m5lzpXQZ471o2mON+0xJ439Kf1S
         7xvjySWWTxiTV6fFgbFQkiS2iiZulY4KaWbkOfXo=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.197]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190201141219epcas5p4bbee4a05000bea9d9390d39ff0a8e5f8~-QuMP5fmr2793627936epcas5p4X;
        Fri,  1 Feb 2019 14:12:19 +0000 (GMT)
X-AuditID: b6c32a4a-b07ff70000001029-24-5c5453c34ee9
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.99.04137.3C3545C5; Fri,  1 Feb 2019 23:12:19 +0900 (KST)
Mime-Version: 1.0
Subject: race between flush_to_ldisc and pty_cleanup
Reply-To: maninder1.s@samsung.com
From:   Maninder Singh <maninder1.s@samsung.com>
To:     "peter@hurleysoftware.com" <peter@hurleysoftware.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "keun-o.park@darkmatter.ae" <keun-o.park@darkmatter.ae>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        Rohit Thapliyal <r.thapliyal@samsung.com>,
        Ayush Mittal <ayush.m@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
Date:   Fri, 01 Feb 2019 19:03:26 +0530
X-CMS-MailID: 20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju25lnR3HxObU+LVMPdlHUXWp6ilZCEqMMTMMfZq2DfjhpN87Z
        SvuTpWKYRmWBSGoXSlmjmWmKdlUStNQsuxgUo0yi0C6CpM5oV/Tf8z48z/e87/u9FCGpJyOp
        IoMZcwZWR5NBwvt98fFJfdkH8mSzX6XMaA9mxhYei5iyG3aSudT6S8B86P5CMq+7r5BM/6t/
        gLn76SjTO9AA0gLVZxztInWL006qHzfYROpz7Vagtre/Eapn2tZlkrm67VrMFmAuBhvyjQVF
        hkIVvTdbs0ujTJHJk+RbmVQ6xsDqsYpOz8hM2l2kc/VExxxjdRYXlcnyPC3dsZ0zWsw4Rmvk
        zSoamwp0JrnClMyzet5iKEzON+q3yWUyhdKlPKLTjjongelvePG1608CSsFiSBWgKAS3oNpq
        URUIoiSwB6Bn0+8JNy+GIWixK7QKBFKhLsnAj3nCjSUwFr2sswG3JBTK0HzHJjdNwmRk7X4g
        dD8TBt8CNDv1jXQXBJwAaOxtn8eMoBjVVX4VevEa1NncAbw4HI3fnhL58c/+Jh8fhio+Dfm8
        Icgx1+Pj16Lb92o8aQhWAtTpeCHwFpcAKh/96EtIRSMDTR63GO5DFTUODy+E69HTU5MBXk06
        slmfeDQEjEadU1c80xMwHtm7pV5JFLo8eEfglaxENQsTAv8wXY1+vB6Vj7cG+Aeb+f3b14Ia
        1Z52kN7N7UfTjxoF50F0/dJ+65cF1y8FXwWEFURgE68vxLzSpDDg48s/tQ147jJhTxe4NZzR
        CyAF6GBx63xWniSAPcaX6HsBogg6TNySfiBPIi5gS05gzqjhLDrM9wKlawUXiMjwfKPryg1m
        jVypSEmRbZUpNzMpcnq1uCGq4aAEFrJmfBRjE+b8PgEVGFkKdsrv/xp+NNlzMVj/mR0cRA9j
        2crWpHHTkYxz77gcjfOk86xUc3iqakZrS2yets3d/Pa8Ij8hqBiu+FznSDwvjL2cmzaRtUEg
        uxVX/b1Z8WywOqe/bGh4lehQXJRl55mRjQNPVRHO2U0d0g+RoyDUvqtRNfHnLpeZ9eb6oQVr
        VCot5LWsPIHgePY/TI6uSK0DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599
References: <CGME20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


There is some race condition between tty_port_put and flush_to_ldisc
which lead to use after free case:
(Kernel 4.1)

[1403.5130] Unable to handle kernel paging request at virtual address 6b6b6b83
...
...
...

[1403.5132] [<c036a65c>] (ldsem_down_read_trylock) from [<c0367db4>] (tty_ldisc_ref+0x24/0x60)
[1403.5132] [<c0367d90>] (tty_ldisc_ref) from [<c03690cc>] (flush_to_ldisc+0x6c/0x21c)
[1403.5132]  r5:dbcd4a84 r4:00000000
[1403.5132] [<c0369060>] (flush_to_ldisc) from [<c0049f18>] (process_one_work+0x214/0x570)
[1403.5132]  r10:00000000 r9:ddab0000 r8:e3d6e000 r7:00000000 r6:e453f740 r5:cb37b780
[1403.5132]  r4:dbcd4a84
[1403.5132] [<c0049d04>] (process_one_work) from [<c004a2d4>] (worker_thread+0x60/0x580)
[1403.5132]  r10:e453f740 r9:ddab0000 r8:e453f764 r7:00000088 r6:e453f740 r5:cb37b798
[1403.5132]  r4:cb37b780
[1403.5132] [<c004a274>] (worker_thread) from [<c005022c>] (kthread+0xec/0x104)
[1403.5132]  r10:00000000 r9:00000000 r8:00000000 r7:c004a274 r6:cb37b780 r5:d8a3fc80
[1403.5132]  r4:00000000
[1403.5132] [<c0050140>] (kthread) from [<c00107d8>] (ret_from_fork+0x14/0x3c)


for checking further we entered some debug prints and added delay in flush_to_ldisc to reproduce
and seems there is some issue with workqueue implementation of TTY:

bool tty_buffer_cancel_work(struct tty_port *port)
{
        bool ret;
        ret = cancel_work_sync(&port->buf.work); // Check return value of cancel_work_sync
        pr_emerg("Work cancelled is 0x%x %pS %d\n", (unsigned int)&port->buf.work, (void *)_RET_IP_, ret); 
        return ret;
}

static void flush_to_ldisc(struct work_struct *work)
{
...
        mdelay(100);   // Added Delay to reproduce race

        if (flag_work_cancel) {
                pr_emerg("scheduled work after stopping work %x\n", (unsigned int)work);

....
}

static void pty_cleanup(struct tty_struct *tty)
{
...
        flag_work_cancel = 1;
		...
}


[1403.4158]Work cancelled is dbcd4a84 tty_port_destroy+0x1c/0x6c  0       // Since return is 0 so no work is pending 

[1403.5129] scheduled work after stopping work dbcd4a84    // Still same work is scheduled after cancelled
[1403.5130] Unable to handle kernel paging request at virtual address 6b6b6b83   // Kernel OOPs occured because of use after free


Using JTAG we fetched free and allocation BT for pty port is:

Free Path:
pty_cleanup
release_one_tty
process_one_work
worker_thread
kthread
ret_from_fork

Allocation Path:
pty_unix98_install
tty_init_dev
ptmx_open
chrdev_open
do_dentry_open
vfs_open
do_last.isra.10

we already applied below patches:
https://lore.kernel.org/patchwork/patch/862594/

But seems it is different case.

Can you suggest any possible fix for this?

Thanks,
Maninder Singh
