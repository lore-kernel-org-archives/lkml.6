Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E14C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E31218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bbC8aEQ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfBAPb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:31:57 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:41721 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfBAPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:31:56 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190201153153epoutp04830176205705695c064694e664afae50~-RzqRFv3y1033110331epoutp04j
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 15:31:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190201153153epoutp04830176205705695c064694e664afae50~-RzqRFv3y1033110331epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549035113;
        bh=ECge2bz3yI2kUVasvFjHTRQ9dXDXhJUc9sIKWLxW9z4=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=bbC8aEQ+b4O5SEvztQX04ohNqG52RX4zepLjZjiHVBbk2RgocGCQcRsRR56x42tLL
         MilUwHPjaDfGoviyTQgW886zEBrkbDt40PjNFLGf9CuV0VN54q3PNriaG9pIViAs1N
         tXko+Htg/AzuowfKk5qIIc3mByMFI3qLvWSoLH0o=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.198]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190201153151epcas5p246665a3c6449c4118b5990b37ae68345~-RzoEq2_O1632216322epcas5p2d;
        Fri,  1 Feb 2019 15:31:51 +0000 (GMT)
X-AuditID: b6c32a4b-4afff70000001028-df-5c5466670693
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.CC.04136.766645C5; Sat,  2 Feb 2019 00:31:51 +0900 (KST)
Mime-Version: 1.0
Subject: RE: race between flush_to_ldisc and pty_cleanup
Reply-To: maninder1.s@samsung.com
From:   Maninder Singh <maninder1.s@samsung.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter@hurleysoftware.com" <peter@hurleysoftware.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "keun-o.park@darkmatter.ae" <keun-o.park@darkmatter.ae>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>,
        Rohit Thapliyal <r.thapliyal@samsung.com>,
        Ayush Mittal <ayush.m@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190201142642.GB3211@kroah.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190201143747epcms5p579d523f0458736dcaaf55dec453cf6b9@epcms5p5>
Date:   Fri, 01 Feb 2019 20:07:47 +0530
X-CMS-MailID: 20190201143747epcms5p579d523f0458736dcaaf55dec453cf6b9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTmt7tdr9Hq11Q6Wda6FGWhbdrW7aFESQysGDkKyloX/bWJe7U7
        s0VB9DKMpIdRydaTKEzUlubUorCYGL3sYZlkizKi0DKDyiza3YP67zsf3znfeTGU4iKdzBTZ
        XMRp4y0sPUp67XZqapppkyFfVXYDc52thHv662Yct/t8Hc1V1n+RcC9b3tLckxYPzQUe/0Hc
        ld5irq3DixbH6/YHG+J0l0bqaN1Nb02crqKhGunqGp5JdUO+yXp6rWWRmfCFxKkktgJ7YZHN
        lMXm5hmXGjValTpNPZ+bxyptvJVksTnL9WnLiiyhnljlFt5SEqL0vCCwc7IXOe0lLqI02wVX
        FkschRaHOsORLvBWocRmSi+wWxeoVaoMTUi50WIeqPEgx4EpW99UtKOdaADKUTwDeC58GX5F
        l6NRjAK3ImiurJaUI4aR43Hw258gahIwBw/KP9AiVuCp8OhEDRIlCVgFw40zRZrG6VDdcl0q
        lknEXQgu9O2XiQGF3yF42nWbipjJ4URZnzSCJ0LTxUYk4vhQdvB3MKpJgu7L/XEx/DlwGkVw
        IuztvR/VjIPgz9YoPwkuXz0YdgZchqApeE8SCSoR7Ol8FXWbBw87Toez5XgFnHwRCGMpng5d
        985S4jiAc6DRs1KkKTwFmvo9YZrCqVDXMidSJQWO3a2VRCRj4OCvd5LYXP5TMTwd9nTXy2Iz
        Dg0ORjvQwdFdweiimxH4y4LUIaSs+rfrqv+cq/45n0FUNZpAHILVRASNI9NGSv+/sA+Fn3RW
        rh/5HixvQ5hB7Gh5/fCqfIWM3yK4rW0IGIpNlAvrDPkKeSHv3kacdqOzxEKENqQJreAwlZxU
        YA+9vM1lVGsytFrVfJUmk9Oq2fFyb4p3nQKbeBcpJsRBnLE8CROfvBPt6Kx1ug91uEr31RqK
        RzBo27Pz1jevn/a1b+b9W0s+ugMLcs6N3TxwnMrL8PoulPYYDZ8ykzY8kqScXLPwR7baf6A2
        sV9nHtnmcQf03WRoTe41Tja6Z6XX8Od1u3KVuYKz9L7vmaGxfw+OHxx0H1n4uN336Zxkwrc7
        q7frnxtls1mpYObVsyinwP8FHBE2y7oDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599
References: <20190201142642.GB3211@kroah.com>
        <20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
        <CGME20190201133326epcms5p506416bc4ae22f600ee705f146ca1a599@epcms5p5>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>On Fri, Feb 01, 2019 at 07:03:26PM +0530, Maninder Singh wrote:
>> Hi,
>> 
>> 
>> There is some race condition between tty_port_put and flush_to_ldisc
>> which lead to use after free case:
>> (Kernel 4.1)
>> 
>> [1403.5130] Unable to handle kernel paging request at virtual address 6b6b6b83
>> ...
>> ...
>> ...
>> 
>> [1403.5132] [<c036a65c>] (ldsem_down_read_trylock) from [<c0367db4>] (tty_ldisc_ref+0x24/0x60)
>> [1403.5132] [<c0367d90>] (tty_ldisc_ref) from [<c03690cc>] (flush_to_ldisc+0x6c/0x21c)
>> [1403.5132]  r5:dbcd4a84 r4:00000000
>> [1403.5132] [<c0369060>] (flush_to_ldisc) from [<c0049f18>] (process_one_work+0x214/0x570)
>> [1403.5132]  r10:00000000 r9:ddab0000 r8:e3d6e000 r7:00000000 r6:e453f740 r5:cb37b780
>> [1403.5132]  r4:dbcd4a84
>> [1403.5132] [<c0049d04>] (process_one_work) from [<c004a2d4>] (worker_thread+0x60/0x580)
>> [1403.5132]  r10:e453f740 r9:ddab0000 r8:e453f764 r7:00000088 r6:e453f740 r5:cb37b798
>> [1403.5132]  r4:cb37b780
>> [1403.5132] [<c004a274>] (worker_thread) from [<c005022c>] (kthread+0xec/0x104)
>> [1403.5132]  r10:00000000 r9:00000000 r8:00000000 r7:c004a274 r6:cb37b780 r5:d8a3fc80
>> [1403.5132]  r4:00000000
>> [1403.5132] [<c0050140>] (kthread) from [<c00107d8>] (ret_from_fork+0x14/0x3c)
>> 
>> 
>> for checking further we entered some debug prints and added delay in flush_to_ldisc to reproduce
>> and seems there is some issue with workqueue implementation of TTY:
>> 
>> bool tty_buffer_cancel_work(struct tty_port *port)
>> {
>>         bool ret;
>>         ret = cancel_work_sync(&port->buf.work); // Check return value of cancel_work_sync
>>         pr_emerg("Work cancelled is 0x%x %pS %d\n", (unsigned int)&port->buf.work, (void *)_RET_IP_, ret); 
>>         return ret;
>> }
>> 
>> static void flush_to_ldisc(struct work_struct *work)
>> {
>> ...
>>         mdelay(100);   // Added Delay to reproduce race
>> 
>>         if (flag_work_cancel) {
>>                 pr_emerg("scheduled work after stopping work %x\n", (unsigned int)work);
>> 
>> ....
>> }
>> 
>> static void pty_cleanup(struct tty_struct *tty)
>> {
>> ...
>>         flag_work_cancel = 1;
>>                 ...
>> }
>> 
>> 
>> [1403.4158]Work cancelled is dbcd4a84 tty_port_destroy+0x1c/0x6c  0       // Since return is 0 so no work is pending 
>> 
>> [1403.5129] scheduled work after stopping work dbcd4a84    // Still same work is scheduled after cancelled
>> [1403.5130] Unable to handle kernel paging request at virtual address 6b6b6b83   // Kernel OOPs occured because of use after free
> 
>Ok, after my initial "use a newer kernel" comment, this really does look
>strange.  There has also been a lot of workqueue fixes and rework since
>4.1, and that might be the thing that fixes this issue here.
> 
>However, are you sure you are not just calling flush_to_ldisc() directly
>through some codepath somehow?  If you look at the stack in the

Yes, there is no call path for flush_to_disc directly. It is all aligned with kernel 4.1.


>pr_emerg() message, where did it come from?  From the same workqueue
>that you already stopped?

We added debug prints to check "work" in pty_cleanup() & flush_to_ldisc

> 
>Testing on a newer kernel would be great, if possible.

We are facing it hard, but currently we have 4.1 and able to reproduce on that.
Not really possible to have the latest kernel on the same target and may be reproduce the same race.
Tried to track for changes in the other stable branches, but no change looks really relevant for this race.
I might be wrong, please help if there is any commit related with this.

> 
>thanks,
> 
>greg k-h

Our initial debugging direction was with "tty" but looks some issue in workqueue.
Also, the most surprising looks to be the CANCEL and FLUSH to be occuring on the same CORE in sequence.
So, if the CANCEL really worked how can the flush_to_ldisc be scheduled.

Thanks,
Maninder Singh
