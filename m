Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127B2C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D762C2146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u3/acRaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfAKEYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 23:24:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbfAKEYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 23:24:44 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0B4JUEo088709;
        Fri, 11 Jan 2019 04:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JUWv9miuQ8DlYNRugLJEESWd+BCSHRAkgrTnic8hImQ=;
 b=u3/acRaC5fNgsAipB43kj5r42cxfUen71Ce5fUPTXO2S7UWUipbmsIZqV7zWrHZ12MTc
 OikFb/I3V1FF5P/NQaqcXGsNF1caTRMZBW86RhbmzE1oMdvxhV9M8vE9O96a+/msC232
 XGEPzyohX8LxP5BWk/yMyZXH4Afo15F861z8ESQNyHkHwSHmhIbJlya4fvfzNTB9FCww
 5rEPY5V/TzWl4mij3Mz/h0eri3mKVlI8WQXokLINfdElTHHQNVHSZZBwjD/h9hz4I6Bk
 A6hkpb/YIcOB7LINnrN8MqKTWBUD4l/khT8WoURVYhIH7npPVcPX085cRdbyfmbFiUgw rA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ptn7rakjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 04:24:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0B4OGOR013673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jan 2019 04:24:16 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0B4OFbq006838;
        Fri, 11 Jan 2019 04:24:15 GMT
Received: from [10.39.212.228] (/10.39.212.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 20:24:14 -0800
Subject: Re: [PATCH 1/3] coredump: Replace opencoded set_mask_bits()
To:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-mm@kvack.org,
        peterz@infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
 <1547166387-19785-2-git-send-email-vgupta@synopsys.com>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <c513c1df-00f3-8c41-3d42-524992b011b1@oracle.com>
Date:   Thu, 10 Jan 2019 20:24:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1547166387-19785-2-git-send-email-vgupta@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=823
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901110035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/19 4:26 PM, Vineet Gupta wrote:
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: http://lkml.kernel.org/g/20150807115710.GA16897@redhat.com
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>

