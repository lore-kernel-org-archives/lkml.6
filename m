Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C68C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D647208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D647208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeHWFLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeHWFLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:11:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 580B230820C0;
        Thu, 23 Aug 2018 01:44:40 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4569F81E25;
        Thu, 23 Aug 2018 01:44:40 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 07E33180053A;
        Thu, 23 Aug 2018 01:44:40 +0000 (UTC)
Date:   Wed, 22 Aug 2018 21:44:39 -0400 (EDT)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Message-ID: <1700708517.23372352.1534988679944.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH2r5mt4Xd7Z86MSxFXNS___sJQjN5KJTH+XLXJcqT0=97wE9A@mail.gmail.com>
References: <CAH2r5mtO6545itRxAV0KW7NSt7ucvxgHOtg8wUZZ0DMHO-V8XQ@mail.gmail.com> <CAH2r5mt4Xd7Z86MSxFXNS___sJQjN5KJTH+XLXJcqT0=97wE9A@mail.gmail.com>
Subject: Re: Overview of performance improvements of recent SMB3 compounding
 patches
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.54.77, 10.4.195.26]
Thread-Topic: Overview of performance improvements of recent SMB3 compounding patches
Thread-Index: TCQtQ+tUV7kxQDx2YhkWgkxBNHSd0w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 23 Aug 2018 01:44:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We also have stat() that drops from 6 to 2 roundtrips.

For metadata I think the only remaining low hanging fruit is readdir().
Currently in cifs.ko scanning a directory takes a minimum of 4 roundtrips :

open
query and get data
query and get the error STATUS_NO_MORE_FILES
close


For small-ish directories (the common case I expect will be that almost all directories will fit in one reply of data)
we can cut this down to just a single roundtrip by using the compound :

open; query; query; close

If the second query fails with the error above we know we are done and we finished in a single
roundtrip.

The drawback is for the rare cases where the directory did not fit in the reply, then
we will have to throw all the data away and re-start from scratch using the old loop thus making all large directory scans
even slower than they are right now, well just one roundtrip slower but still.
(Technically, the protocol does support re-opening a directory and resuming at a specific FileIndex  but it is not implemented server-side.)

I think it will still be worth it if we can get the common case to drop from 4 to 1 roundtrip.

It will involve touching cifs_readdir() which is hairy code but if someone would want to tackle this I think there is opportunity to make
a huge impact on directory listing performance.


regards
ronnie sahlberg




----- Original Message -----
> From: "Steve French" <smfrench@gmail.com>
> To: "CIFS" <linux-cifs@vger.kernel.org>, "samba-technical" <samba-technical@lists.samba.org>, "LKML"
> <linux-kernel@vger.kernel.org>, "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "ronnie sahlberg"
> <ronniesahlberg@gmail.com>
> Sent: Thursday, 23 August, 2018 5:28:01 AM
> Subject: Re: Overview of performance improvements of recent SMB3 compounding patches
> 
> Continuing the experiments with Ronnie's patches show additional
> promising performance results from other common scenarios:
> 
> Very good news that the number of roundtrips (request/response pairs
> to the server) has dropped so substantially.  Reducing latency, and
> allowing the server to more efficiently process the requests leads to
> much better performance for these common operations:
> 
> - rename goes from 9 request/response pairs to 5 ("mv /mnt/file /mnt/file1")
> - hardlink goes from 8 to only 3 (!)  ("ln /mnt/file1 /mnt/file2")
> - symlink (with mfsymlinks enabled) goes from 11 to 9 ("ln -s
> /mnt/file1 /mnt/file3")
> - touch (existing file) 6 down to 4
> 
> In current kernel we benefit from compounding now on stafs ("stat -f
> /mnt"), and in the earlier note I described the improvements in
> create, unlink, mkdir and rmdir which were also awesome.
> 
> This is very exciting.
> 
> On Tue, Aug 21, 2018 at 1:24 PM Steve French <smfrench@gmail.com> wrote:
> >
> > In experiments today with Ronnie's most recent compounding patches I
> > see the expected significant improvements in create/mkdir/unlink/rmdir
> > operations over SMB3 mounts (tests were to Samba but would be similar
> > to all modern servers).  See below:
> >
> > "touch /mnt/file"  goes from 6 request/response pairs to 4 with
> > Ronnie's compounding patches
> > "rm /mnt/file" from 5 to 2 request/response pairs
> > "mkdir /mnt/newdir" 6 pairs to 3 pairs
> > "rmdir /mnt/newdir" 6 pairs down to 2 pairs
> >
> > Good job Ronnie!
> > --
> > Thanks,
> >
> > Steve
> 
> 
> 
> --
> Thanks,
> 
> Steve
> 
