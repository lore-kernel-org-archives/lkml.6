Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76F5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3D3217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdhhhUw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfAWSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:08:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33560 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:08:57 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NI42jc067366;
        Wed, 23 Jan 2019 18:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bQcmAj+uxiGdd1ToStbp1zvuhsqB4tnv+6umvvuRPCY=;
 b=ZdhhhUw8/n6+xDnzfuz3LkPsxAM5pViK0ucH4703l+jJkxM1ULieqArPPN7HpcWYVkKn
 Hda80UHAQyWCpH558Vg4JZ/NMsTIfmkJH0AGA9FR9sa1shVPIHDHtTLOcf9RmgnSXzD9
 3ga4bIvDNN9lLbGXnXha0OC1QXkpwMfPWOSrLMUZaUioM0iCO+fiQjcBX/Ycfllsm9ek
 mch+utHW3Uc/8dpoYFG/sYZhAl3hRR+SUdu8bcErw9Z6rhPbu7ZWjAf38qsdZ0JqHerW
 ocmCMzaUP4SHHM+tmwK0ApwN6izTzOJe1WPHNBzW7KpD0ToXQiBvt9MT6bFgG/JyInKY Ew== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q3sdekpxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:08:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NI8qbJ025630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:08:52 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0NI8ppJ003371;
        Wed, 23 Jan 2019 18:08:51 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 10:08:51 -0800
Date:   Wed, 23 Jan 2019 13:08:37 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 10/13] KVM/nSVM: Use the new mapping API for mapping
 guest memory
Message-ID: <20190123180835.GO19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-11-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-11-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=823
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:10AM +0100, KarimAllah Ahmed wrote:
> Use the new mapping API for mapping guest memory to avoid depending on
> "struct page".
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
