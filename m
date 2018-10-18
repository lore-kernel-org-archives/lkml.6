Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21627C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10CD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EC64gsft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10CD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJSH57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:57:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34098 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeJSH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:57:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9INsRsY129889;
        Thu, 18 Oct 2018 23:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=YqT3Yb3nrKXrchDb47c0C3TQTAcOOmXghkf5DxB1H1E=;
 b=EC64gsftvAQYf3Qx3Oj8EboCq1STViJOFEPvZBwup+sp5AmXfaQQOHs4UEAzeA3axWdy
 YOuxGiVyKlElpFeL8MKCO+syRhuKBw88youHnDt0/PoL35buF2gnh74EunP8sGCKnWFJ
 4MlywYNzQJHv11yiAzfpdt36VL4P0uuUB2fCM/VMu5+NeJloB5bFZF9bKo4i/cgZA/Pj
 e0BXL3oWZzfB0Qt6I26DiU81B+avOKzJ+hKvr/aB4LqtzWCIiGJ1ebfJ/OIr4QFn8q2v
 D3UWPnslMyCtNMdTC/R8ijytPRt6TOkmo65ieTPDbNOmn5+a/VxYvbfZubs8R9VF6DLA 0g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n39brsafu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 23:54:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9INsLnH030537
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 23:54:21 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9INsKSF024233;
        Thu, 18 Oct 2018 23:54:20 GMT
Received: from konrads-mbp.lan (/209.6.36.129)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Oct 2018 16:54:20 -0700
Date:   Thu, 18 Oct 2018 19:54:17 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, jgross@suse.com,
        boris.ostrovsky@oracle.com, axboe@kernel.dk
Subject: Re: [PATCH v2] xen/blkfront: avoid NULL blkfront_info dereference on
 device removal
Message-ID: <20181018235417.GB36047@konrads-mbp.lan>
References: <20181015132508.23293-1-vliaskovitis@suse.com>
 <20181015140201.elir7ettk7sz4aix@mac.bytemobile.com>
 <b0b793a6cdfd634e126fbb00554ca68a780a00bd.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0b793a6cdfd634e126fbb00554ca68a780a00bd.camel@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:25:56PM +0200, Vasilis Liaskovitis wrote:
> On Mon, 2018-10-15 at 16:02 +0200, Roger Pau Monné wrote:
> > 
> > > This results in a NULL pointer BUG when blkfront_remove and
> > > blkif_free
> > > try to access the failing device's NULL struct blkfront_info.
> > > 
> > > 
> > I guess this is a candidate for backporting?
> > 
> 
> yes, I think so. At least for kernels >=4.5, which could face this
> issue due to commit c31ecf6c12 (this frees the struct blkinfo in the
> failing path of talk_to_blkback).

OK, applied with Cc: stable@vger.kernel.org
> 
> thanks, 
> 
> - Vasilis
> 
> 
