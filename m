Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BDDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF80E21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1L4zTNlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbeLUAjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:39:15 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37194 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeLUAjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:39:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBL0YdRu063895;
        Fri, 21 Dec 2018 00:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=ZW6Gn3yLEAOqVVPxee2LZAIl4uFwpMlhB2gqbXUD6Xo=;
 b=1L4zTNlVyerNXL/vMRNsaB/wh5m09BzwB/LBarHHPPzk/JQevulfuTAX9VoOVP1esdB9
 uX+mGKTSstvA18wCT9ofnclhYsw8HxW0cjB1NyM7QLHHSPMPNhnPm1Aprzq/Ay3w3rat
 DN1Wyh6bhEe4lCjkqjlpY7I4j/INKb6i9RH8DEQDzJTBm4d9URKOgWqr5ASh0y3yMsCq
 psBaNc1PdXYp8JDja/NOKl5KIEu0TeS/Yrct66wUc4QmoLoFtsiP/xi/IM2N12m5ZOi1
 MYvZRvYD52ziSGpIGlkZMokA0YtQo0SsEBPPGpbjt5aoHybC5TUUd8QWZ/J+xIFah85n VQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2pf8gfkp8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 00:39:05 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBL0d4QI018101
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Dec 2018 00:39:05 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBL0d3ev031781;
        Fri, 21 Dec 2018 00:39:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Dec 2018 16:39:02 -0800
To:     Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Cc:     <don.brace@microsemi.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <yu.zheng@hxt-semitech.com>,
        <jinyanjiang@gmail.com>, <esc.storagedev@microsemi.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: smartpqi: call pqi_free_interrupts() in pqi_shutdown()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1545294755-29565-1-git-send-email-yanjiang.jin@hxt-semitech.com>
        <1545294755-29565-2-git-send-email-yanjiang.jin@hxt-semitech.com>
Date:   Thu, 20 Dec 2018 19:39:00 -0500
In-Reply-To: <1545294755-29565-2-git-send-email-yanjiang.jin@hxt-semitech.com>
        (Yanjiang Jin's message of "Thu, 20 Dec 2018 16:32:35 +0800")
Message-ID: <yq1k1k3d87v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9113 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=693
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812210002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yanjiang,

> We must free all irqs during shutdown, else kexec's 2nd kernel would
> hang in pqi_wait_for_completion_io() as below:

Applied to 4.21/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
