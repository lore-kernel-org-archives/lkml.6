Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0BC20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="blEnRgQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0BC20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeGYQjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:39:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35042 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbeGYQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:39:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6PFNdOh171140;
        Wed, 25 Jul 2018 15:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=58tkg3WyrisZMa0y69re/Yopb27hA6C9YptAv71Z8vc=;
 b=blEnRgQAdJMUgUp66TBboMJW1Mx1DDqiCtDSrFyJIerTmgmAUgZqISfTbNnAhWNDTLIh
 oDNZto9Rm/1n1D9FjQfC4lvE3Jr6MS7PIYWxXroIsqsKVqGgyB8wptVI432+N5JCO8Um
 27/g8SiStLK2MY2swiHIBvG234N68QDPEMj3jnWRYLoB5WG1iWwUJSRTch8Pk4ex2n8G
 IVqAt0pbmmvtEeKIVBfUcYQ/tPLnwrGRWZaWIkOvVuCbl+F/FqoFPRGRVRqL27eqgah4
 WSEYnjyNXgP+SKUfQS2SvBpbA3N20Eo/HUi5LTSZwwbt6TNLRuWlYl3zVWHjm3xxOIMq uw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kbwfpwx95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 15:27:32 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6PFRVO8007160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 15:27:31 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6PFRVbc019293;
        Wed, 25 Jul 2018 15:27:31 GMT
Received: from oracle.com (/10.39.227.239)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Jul 2018 08:27:31 -0700
Date:   Wed, 25 Jul 2018 11:27:25 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rds: send: Fix dead code in rds_sendmsg
Message-ID: <20180725152725.GD8870@oracle.com>
References: <20180725152227.GA26303@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725152227.GA26303@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=840
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/25/18 10:22), Gustavo A. R. Silva wrote:
> Currently, code at label *out* is unreachable. Fix this by updating
> variable *ret* with -EINVAL, so the jump to *out* can be properly
> executed instead of directly returning from function.
> 
> Addresses-Coverity-ID: 1472059 ("Structurally dead code")
> Fixes: 1e2b44e78eea ("rds: Enable RDS IPv6 support")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
