Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBB8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E927620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E927620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755076AbeFRP04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:26:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754481AbeFRP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:26:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5IFKXsZ102374
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:26:53 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jpcc60kxs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:26:53 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bblock@linux.vnet.ibm.com>;
        Mon, 18 Jun 2018 16:26:52 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Jun 2018 16:26:49 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5IFQma028573842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 15:26:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B81BA4051
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:17:32 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3587A4059
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:17:31 +0100 (BST)
Received: from bblock-ThinkPad-W530 (unknown [9.152.212.94])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:17:31 +0100 (BST)
Received: from bblock (uid 1000)
        (envelope-from bblock@linux.vnet.ibm.com)
        id 3003a460
        by bblock-ThinkPad-W530 (DragonFly Mail Agent v0.9);
        Mon, 18 Jun 2018 17:26:45 +0200
Date:   Mon, 18 Jun 2018 17:26:45 +0200
From:   Benjamin Block <bblock@linux.vnet.ibm.com>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        security@kernel.org
Subject: Re: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in
 release
References: <20180615152335.208202-1-jannh@google.com>
 <20180615164009.GD30522@ZenIV.linux.org.uk>
 <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90063ef3-68fa-e983-9b47-838e6076b0f4@interlog.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18061815-0028-0000-0000-000002D228E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061815-0029-0000-0000-000023896395
Message-Id: <20180618152645.GA15656@bblock-ThinkPad-W530>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806180180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 04:47:47PM -0400, Douglas Gilbert wrote:
> On 2018-06-15 12:40 PM, Al Viro wrote:
> > On Fri, Jun 15, 2018 at 05:23:35PM +0200, Jann Horn wrote:
> > 
> >> I've mostly copypasted ib_safe_file_access() over as
> >> scsi_safe_file_access() because I couldn't find a good common header -
> >> please tell me if you know a better way.
> >> The duplicate pr_err_once() calls are so that each of them fires once;
> >> otherwise, this would probably have to be a macro.
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Jann Horn <jannh@google.com>
> >> ---
> > 
> > WTF do you mean, in ->release()?  That makes no sense whatsoever -
> > what kind of copy_{to,from}_user() would be possible in there?
> 
> The folks responsible are no longer active in kernel development ***
> but as far as I know the async write(command), read(response) were
> added to bsg over 10 years ago as proof-of-concept and never properly
> worked in this async mode. The biggest design problem with it that I'm
> aware of is that two tasks which issue write(commands) at about the
> same time to the same device can receive one another's read(response).
> The tracking of which response belongs to which task is in part the
> reason why the sg driver's data structures are more complex than the
> bsg driver's are. Hence the code work to fix that problem in the bsg
> driver is not trivial and probably a reason why no-one has attempted it.
> 
> Once real world users (needing an async SCSI (or general storage)
> pass-through) find out about that bsg "feature", they don't use it.
> They use the sg driver or something else. So the fact that bsg has
> other glaring errors in it in async mode is no surprise to me.
> 
> When I took over the maintenance of the sg driver in 1998, it only
> had an async (i.e. write(command), read(response)) interface.
> The SG_IO ioctl was added at the suggestion of Jørg Schilling (of
> cdrecord "fame"). The sg driver implementation was essentially to
> put a write(command) and read(response) back-to-back. The bsg driver
> came along later and started with the synchronous SG_IO ioctl
> interface only. The async write(command)/read(response) functionality
> was added later to bsg. Perhaps that part of the bsg driver should be
> deprecated/withdrawn if a maintainer/rewriter cannot be found.
> [BTW the bsg sync SG_IO ioctl implementation can probably get the
> wrong response, it's just that the window is a lot narrower.]
> 
> That said, the bsg driver has lots of other users. For example it is
> the only generic pass-through in Linux for the SAS Management Protocol
> (SMP) used to control SAS based storage enclosures. I have a user space
> package based on it (in Linux) called smp_utils which works well IMO.
> However disk enclosures won't typically have contention between users
> trying to control them and I'm not aware of any disk enclosures that
> support Persistent Reservations. So the bsg driver's "async" problems
> are not a practical issue in this case. Also I believe some high end
> storage hardware uses bsg to communicate with their hardware from their
> user space tools.
> 

We definitely use the BSG IOCTL part for FC-Command passthrough (and
other SCSI transports need it for theirs too, SAS, iSCSI, ...). And I am
not aware of any other way to do that right now. So this can not go away
without someone giving us a different way to do that.

That said.. the read()/write() interface is just pointless atm, I don't
see any sane way of using that in userspace.

FWIW, I actually thought about rewriting that part so it becomes
somewhat sane (tracking which thread sends what command and so on), but
haven't had time to really doing it. With the whole discussion now, I am
not sure anyone really needs that anyway.


- Benjamin

--
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Development
IBM Systems & Technology Group   /  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Martina Koederitz       /      Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294

