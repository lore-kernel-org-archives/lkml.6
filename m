Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6089DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03D8208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 21:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="A35EQcIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03D8208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeGJVq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 17:46:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59206 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732268AbeGJVqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 17:46:25 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ALhTFI010136
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:45:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : mime-version : content-type; s=facebook;
 bh=LAuGPEq2OCpOgysYTS7GzsOEsniYVUt6yUuoreKlQpE=;
 b=A35EQcIkfkMJjHVy3j34ooAfj3NDRh92qNIYM5DOYh0IKyq1mkpL+KqcQ+y/VchWf4t7
 CQA1gtJS8GurMvTvknnGBWKZz24iSY1vziTu69F+7hR1XKXFSfBu8FVOuA4c2y+IGGwE
 93bUjrdCk0ifP0sThmoiAkZKCVQDTjBVISo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k54u0g0vh-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 14:45:24 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.17) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 10 Jul
 2018 14:45:22 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 516088A458E; Tue, 10 Jul 2018 14:45:22 -0700 (PDT)
Message-ID: <20180710213306.646146378@fb.com>
User-Agent: quilt/0.63-1
Date:   Tue, 10 Jul 2018 14:33:06 -0700
Smtp-Origin-Hostprefix: dev
From:   Okash Khawaja <osk@fb.com>
Smtp-Origin-Hostname: dev026.lla1.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: lla1c22
Subject: [PATCH bpf v2 0/1] bpf: btf: Fix endianness of bitfields
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following are the changes from v1:

- use compile time check for endianness
- factor out right_shift_bits from the check as it is same in both
- change size of bit shift variables to match length of bit offset in
BTF specification

Please note that I have considered non-big endians to be little endians
for our purposes. Let me know if you think that's a problem. We need to
then decide what to do in case neither of macros are defined.

Thanks,
Okash
