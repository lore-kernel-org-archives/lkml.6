Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A750AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C342098B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IgkfVBie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C342098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeGJXsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 19:48:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33020 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732270AbeGJXsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 19:48:20 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ANbsbL016760;
        Tue, 10 Jul 2018 16:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=yzqPjBEO2CpJUbJ0S0S9Jbxs3eRX+A5n5j0pW3EOuHY=;
 b=IgkfVBiee54ZqCJcnDwT1qzei8FDZXwxENI28jn7e+TKGK+ZLa3sfwBzU1zchx/1/EnK
 uzS5MZNs+O/ydp5TXpD5uryxjnrGdMmtslEP5PRPPD0LYETj32QFKMbzSGRpGb/PgjuF
 Mj0rlaLP5E8TP8KjkuGc8JVfmku/xlsKROc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k56by01vr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 10 Jul 2018 16:46:28 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 10 Jul 2018 16:46:21 -0700
Date:   Tue, 10 Jul 2018 16:46:16 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Okash Khawaja <osk@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/1] bpf: btf: Fix bitfield extraction for big
 endian
Message-ID: <20180710234528.2kj2kv7gjmigvvgp@kafai-mbp.dhcp.thefacebook.com>
References: <20180710213306.646146378@fb.com>
 <20180710214522.339195416@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180710214522.339195416@fb.com>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 02:33:07PM -0700, Okash Khawaja wrote:
> When extracting bitfield from a number, btf_int_bits_seq_show() builds
> a mask and accesses least significant byte of the number in a way
> specific to little-endian. This patch fixes that by checking endianness
> of the machine and then shifting left and right the unneeded bits.
> 
> Thanks to Martin Lau for the help in navigating potential pitfalls when
> dealing with endianess and for the final solution.
> 
> Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
> Signed-off-by: Okash Khawaja <osk@fb.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
