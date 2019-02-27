Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56944C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E792147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NjERMlv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbfB0OBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:01:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42120 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbfB0OBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:01:06 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1RDxU4T095080;
        Wed, 27 Feb 2019 14:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=K/eKPEdTVrkZZ0PkkMLDeWx8k7EbI0pws6zGOkjt9vk=;
 b=NjERMlv8XkFvFm+BAP15aZ5di+qu8WwAljs3DtI5mBr0G/SQyB2TSN4C7Zpbtj9Zag8R
 9ktm5M4iaj9zo850x0ioLLGphRIGjKmUZlEFdnFnfHl2n8k6kjy5iKgi2PtYAWmIkLBy
 oAZ3ujkGWOMgs39mb0bbTLcpu8x4KwnIX+HF0sTuhvIWQFSVzUgJ4WRZI0pC2jz9gjdI
 4/7Dz40/EtL/lSmxX9BI2PtBnJWPCWiJbZW5yI6kYbvh42q7cLRnRCieHJoxus4MK4k+
 Fm/MAFnrJLpq77BfbHFAl6gw6zXhUzJKfwXOZ29h+MIAZU68OXb5hms/cnGsyJfew5jL Uw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qtupeb6cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 14:00:44 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1RE0gL9002898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 14:00:42 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1RE0f9x021946;
        Wed, 27 Feb 2019 14:00:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Feb 2019 06:00:40 -0800
To:     Avri Altman <avri.altman@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Bean Huo <beanhuo@micron.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: Re: [REPOST PATCH v4 0/3] scsi: ufs-bsg: Add read descriptor
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1550646674-15258-1-git-send-email-avri.altman@wdc.com>
Date:   Wed, 27 Feb 2019 09:00:38 -0500
In-Reply-To: <1550646674-15258-1-git-send-email-avri.altman@wdc.com> (Avri
        Altman's message of "Wed, 20 Feb 2019 09:11:11 +0200")
Message-ID: <yq136o9babd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=504 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902270094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avri,

> UFS Protocol Information Units (UPIU) are UFS packets that travel
> between the host and the device on the UniPro bus. Our previous series
> added the capability to send UPIUs to the ufs driver. It does not
> cover all the possible UPIU types - we are mainly focused on device
> management, provisioning, testing and validation, so it covers UPIUs
> that falls in that box.

Applied to 5.1/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
