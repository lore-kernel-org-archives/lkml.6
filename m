Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E4CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF3021855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a7kPFXVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfAWSEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:04:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38294 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWSEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:04:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NI47WR085331;
        Wed, 23 Jan 2019 18:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=opG7Pp0hxRt3TgH5ZQNu1sxJDgocpQviGagpobD8I9U=;
 b=a7kPFXVnItA2wMjukNydaeJv3gLjpCDqr1x0rbsQQLpVs8EEhjjXTYs7v31KjMj7gsj9
 PWoDxee8QPwQ58De0+Z5WOVuq5rn0Y30usIPv1LIQsdF/20uSZBVKppR2kL/Q9M+VW5R
 lHx8ZGF/Yw2AqetIdzJ+/Wo5TCB3Gy+rF3MHQZtFEXqG5yXranWu77VeKjspmmqMJdoG
 wZevK2hZY8Rwg3SeObPez0MsSg0nZfA2YzpUoaFlhX+djkRCW7mdhVfgm0djHybbA3Zo
 ZjblNHlsnaoNKwueotv2DdwxsE/XD5JulAgUXvQPIf+Isw0NP4oDiTodja0KraA1AgT1 Vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2q3vhrudaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:04:45 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0NI4c5O030798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 18:04:39 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NI4cqf012346;
        Wed, 23 Jan 2019 18:04:38 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 10:04:37 -0800
Date:   Wed, 23 Jan 2019 13:04:19 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 09/13] KVM/X86: Use kvm_vcpu_map in
 emulator_cmpxchg_emulated
Message-ID: <20190123180417.GN19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-10-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-10-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=798
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:42:09AM +0100, KarimAllah Ahmed wrote:
> Use kvm_vcpu_map in emulator_cmpxchg_emulated since using
> kvm_vcpu_gpa_to_page() and kmap() will only work for guest memory that has
> a "struct page".
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Reviewed-by: Konrad Rzeszutek Wilk <kjonrad.wilk@oracle.com>
