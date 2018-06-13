Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C5C81C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0F3208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0F3208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935502AbeFMUak (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:30:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754517AbeFMUai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:30:38 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5DKTGVl088511
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:30:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jk6kd1v2a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 16:30:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 13 Jun 2018 21:30:35 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Jun 2018 21:30:33 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5DKUWG828770524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jun 2018 20:30:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA89352043;
        Wed, 13 Jun 2018 20:19:59 +0100 (BST)
Received: from dhcp-9-2-55-142.watson.ibm.com (unknown [9.2.55.142])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DEF235203F;
        Wed, 13 Jun 2018 20:19:58 +0100 (BST)
Subject: Re: [PATCH] integrity: add error handling for kmem_cache_create
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@google.com>,
        Jeff Layton <jlayton@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jun 2018 16:30:30 -0400
In-Reply-To: <1528777625-40502-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528777625-40502-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18061320-0016-0000-0000-000001DB6F9D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061320-0017-0000-0000-0000322EAD89
Message-Id: <1528921830.3282.7.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806130217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 12:27 +0800, Zhouyang Jia wrote:
> When kmem_cache_create fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kmem_cache_create.

The slab is being create during __init.  Under what circumstances do
you expect the allocation to fail?  Have you tested what happens if it
fails with/without at least an IMA measurement policy?

Mimi
  
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  security/integrity/iint.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 149faa8..c074fd8 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -172,6 +172,9 @@ static int __init integrity_iintcache_init(void)
>  	iint_cache =
>  	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
>  			      0, SLAB_PANIC, init_once);
> +	if (!iint_cache)
> +		return -ENOMEM;
> +
>  	return 0;
>  }
>  security_initcall(integrity_iintcache_init);





