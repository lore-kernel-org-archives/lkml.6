Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE8220647
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tWOG4zVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE8220647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeGTG5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:57:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34758 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeGTG5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:57:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6K68wQO145533;
        Fri, 20 Jul 2018 06:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hI2w+OOrUmbYkTwR8ZooWtOT34GkqLT00MGbg4KtyQg=;
 b=tWOG4zVi6mp5o+0EnNmAlc9OF2dulmQN9zZM2lb4BD+9n5T9J74F9NhvcHNshoJyHpPc
 /ITJQf3zwmRhVuCusefuUOFYHg9kSeUrRlmEcxM+rB6zWUuSOGteprWRcpxtm1Jgy/ob
 ltFt/wf4MSdOAlJMnUANiA4CWs7A30Yz5wBCped3Yeu3D0Airj8/HGayDpc5JH0EdjBk
 gNn3zWVcyRdifCbQBH89bK5w1qsMeWqVvpTkSgWc2GzunoyzyGZq0hQzkdU1nPLeA0En
 Uwbdn3qayjqaulr3CGloXmdZeEYe1lHQPPJQ/eIHFqTOnUUbCPjJZqaaBOO93RMgie/O Pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k7a3tda5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 06:09:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6K69mGw010001
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jul 2018 06:09:48 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6K69kNA015152;
        Fri, 20 Jul 2018 06:09:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 23:09:46 -0700
Date:   Thu, 19 Jul 2018 23:09:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bob Peterson <rpeterso@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH] fs: iomap: Change return type to vm_fault_t
Message-ID: <20180720060944.GA4823@magnolia>
References: <20180702154354.GA3919@jordon-HP-15-Notebook-PC>
 <CAHc6FU6CVaT3W15n4jSiy6F4cZEFa9HdrZ8NRrU2GppTXr7p8A@mail.gmail.com>
 <20180703213943.GU32415@magnolia>
 <CAHc6FU4sZj4DFbQddXk2Uo5Nh4EOFM6rdAnwD3kmnN2RjvL9OQ@mail.gmail.com>
 <CAFqt6zY4BLw4HeaQmwgv2B+hQLnULuyvJDkcRd5-CbYTZuPw+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zY4BLw4HeaQmwgv2B+hQLnULuyvJDkcRd5-CbYTZuPw+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807200073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:31:30AM +0530, Souptick Joarder wrote:
> On Wed, Jul 4, 2018 at 3:22 AM, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > On 3 July 2018 at 23:39, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >> On Mon, Jul 02, 2018 at 07:52:41PM +0200, Andreas Gruenbacher wrote:
> >>> On 2 July 2018 at 17:43, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >>> > Return type has been changed to vm_fault_t type for
> >>> > iomap_page_mkwrite().
> >>> >
> >>> > see commit 1c8f422059ae ("mm: change return type to
> >>> > vm_fault_t") for reference.
> >>> >
> >>> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> >>> > Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> >>
> >> I don't recall Christoph [now cc'd] rescinding his NAK of the previous
> >> version of this patch[1].  Has he changed his mind since May?
> >                                      /|\
> > Oops, a reply gone wrong -- I was me  |   to reply to Souptick
> > Joarder's gfs2 change which I've add  |   the gfs2 for-next branch.
> > Not the iomap change. Sorry for the   |  sion.
> >                                       |
> >> [1] https://spinics.net/lists/linux  |  vel/msg126032.html
> >>                                      |
> >> Now granted I didn't have a problem  |   the code (and applied the xfs
> >> version to 4.18 after monitoring to  |  sfy myself that nothing
> >> particularly weird happened during   |   but seeing as most of the iomap
> >> changes have gone through hch's rev  |  nd landed via the xfs tree...
                                          |
--D                                       |
                                          |
I wasn't planning on it, due to aforementioned NAK still being in place
to the best of my knowledge, at least for the iomap patch.

> Darrick, is this patch going to 4.19 through xfs tree ?
