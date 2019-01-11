Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17260C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC2F2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xDK4i77F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfAKEY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 23:24:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44442 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfAKEY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 23:24:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0B4JNZH132475;
        Fri, 11 Jan 2019 04:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=YvsSemXNt4pNQiU/fC7MOJUnqimZWe3L/FSAEqwqe9c=;
 b=xDK4i77Fwb6/06qILq5TZ6m2RtCXxtdbsMG21hzToT2evOdMJYX5MwKTQ8L/iGSZjP98
 18SRdVpl0WujtA5XywAvSAEuZklawUuHLDVSevBooi++QuVw71YsnG8IXtaVPJ4hCJZt
 gi20wUveRQsSQ+pATqVEeKszJ8lV5PxTnVrmCZPqP1egG9odEh1WI+OOCGF+DTrKCAQq
 L0EmuNt+sGRRGp2bFNhBNlteZ/+u/FA0vkAieV7IVeDqqEAmbYKzpGXJ2bZBCh4l06OM
 DLENmOCC0AwuMZsMHVfOQhwiw9FtKw7BYMp1J7SHr+ESZ1YLTImCgHSLfdDPeBwtcV2r AA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2ptm0ujt6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 04:24:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0B4Okpl004386
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 04:24:46 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0B4OjSI007042;
        Fri, 11 Jan 2019 04:24:45 GMT
Received: from [10.39.212.228] (/10.39.212.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 20:24:45 -0800
Subject: Re: [PATCH 2/3] fs: inode_set_flags() replace opencoded
 set_mask_bits()
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-mm@kvack.org,
        peterz@infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org
References: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
 <1547166387-19785-3-git-send-email-vgupta@synopsys.com>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <5c9bf6bd-e29b-c985-b686-35f6dc272152@oracle.com>
Date:   Thu, 10 Jan 2019 20:24:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1547166387-19785-3-git-send-email-vgupta@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=993
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/19 4:26 PM, Vineet Gupta wrote:
> It seems that 5f16f3225b0624 and 00a1a053ebe5, both with same commitlog
> ("ext4: atomically set inode->i_flags in ext4_set_inode_flags()")
> introduced the set_mask_bits API, but somehow missed not using it in
> ext4 in the end
>
> Also, set_mask_bits is used in fs quite a bit and we can possibly come up
> with a generic llsc based implementation (w/o the cmpxchg loop)
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>

Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
