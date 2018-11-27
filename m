Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDFAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBD120645
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NhaPKM6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBD120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbeK1HLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:11:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52972 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeK1HLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:11:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARK9lxO101362;
        Tue, 27 Nov 2018 20:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0vbFHHFrV4d2joW/Jn/J/EMKdTZbWqTtv9izUoUwJrw=;
 b=NhaPKM6DOxBAyUZcFNCzPz4eciWJ3MT9VsbKoMRDjM67mPciKGd8TbXZfGN6a02QhbLZ
 /sKbKZeJNhaTx2A5kZ4Mc6J8yg+nGTa6b99En+aOclG4bfKzQy0y+gBSuy54pPZRZH6P
 kACLoWg2i9JTgpWlV3LirGiaV5zxXbFJTxFdLAhhPrBgZPDi+cHe93wfIFOZT+yxQp1h
 0iPxF2UUREiJe3L7ZYp0E10pYETYbTDMnbrjfaiM3gkwB2S53w136mHz1LRQf06zmFV0
 uYOLbLGgS+lO/RITRTMCm52XVnQ3j8s9bz0VM4QgM/EDcXwEesBzzF3CfObPduM4lqr5 ig== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2nxx2u6bxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 20:12:34 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wARKCWW9006492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 20:12:33 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wARKCWR9027937;
        Tue, 27 Nov 2018 20:12:32 GMT
Received: from unbuntlaptop (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 12:12:32 -0800
Date:   Tue, 27 Nov 2018 23:12:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Cathy Avery <cavery@redhat.com>
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hch@lst.de,
        jgill@vmware.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, emilne@redhat.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: vmw_pscsi: Rearrange code to avoid multiple calls
 to free_irq during unload
Message-ID: <20181127201222.GA3095@unbuntlaptop>
References: <1543346933-440-1-git-send-email-cavery@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543346933-440-1-git-send-email-cavery@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 02:28:53PM -0500, Cathy Avery wrote:
> Currently pvscsi_remove calls free_irq more than once as
> pvscsi_release_resources and __pvscsi_shutdown both call
> pvscsi_shutdown_intr. This results in a 'Trying to free
> already-free IRQ' warning and stack trace. To solve the problem
> pvscsi_shutdown_intr has been moved out of pvscsi_release_resources.
> 
> Signed-off-by: Cathy Avery <cavery@redhat.com>
> Reviewed-by: Ewan D. Milne <emilne@redhat.com>

That bug has been there since the driver was introduced in 2009.  It's
so amazing that no one has fixed it until now...

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


