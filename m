Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58CCC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9A20896
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 20:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UdlkG6e2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB9A20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeGHUgO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 16:36:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51458 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754289AbeGHUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 16:36:02 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w68KXLmN016499
        for <linux-kernel@vger.kernel.org>; Sun, 8 Jul 2018 13:36:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : mime-version : content-type; s=facebook;
 bh=P3Mzxzjpwp9ViK2zKLb5ExG74ULYHV1LgHxJ+0D9DD4=;
 b=UdlkG6e2IBzPmcE0EHc9pGDMvutbv65k4Z4WAfR09jyFkchUs4cOUz/CAHCTTqa6EiOf
 Cza7n1+HuqozV8bO3AZPdILxtoOXpnQ39TdTl5Ge00aml82j4ci3N/q+sNPKyKgeB++B
 2haBnLjdIaBjJIN4CTCcagrrQAYWVL8AseI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2u1p25fw-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 13:36:01 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.13) with Microsoft SMTP Server (TLS) id 14.3.361.1; Sun, 8 Jul
 2018 13:36:00 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 4D24C8A2461; Sun,  8 Jul 2018 13:33:36 -0700 (PDT)
Message-ID: <20180708203002.543403467@fb.com>
User-Agent: quilt/0.63-1
Date:   Sun, 8 Jul 2018 13:30:02 -0700
Smtp-Origin-Hostprefix: dev
From:   Okash Khawaja <osk@fb.com>
Smtp-Origin-Hostname: dev026.lla1.facebook.com
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: lla1c22
Subject: [PATCH bpf-next v3 0/3] bpf: btf: print bpftool map data with btf
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-08_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This v3 contains incorporates feedback from v2, including a fix for big endian
when extracting bitfields. Below is a summary of all changes.

patch 1:
- use kernel integer types instead of stdint

patch 2:
- change stdint types to kernel equivalents
- remove variable ret from btf_dumper_modifier()
- remove unnecessary parentheses in btf_dumper_enum()
- remove unnecessary parentheses in btf_dumper_array()
- change integer types from explicitly sized to int in btf_dumper_int_bits
- fix btf_dumper_int_bits() so it works for little and big endian
- remove double space in btf_dumper_int()
- print non-printable characters as string
- remove ret variable from btf_dumper_int()
- don't initialise variable with function which needs error check in
  btf_dumper_struct()
- use a temp variable to avoid multi-line statement in btf_dumper_struct()
- call jsonw_end_object before returning in error case in btf_dumper_struct()
- print something in case of BTF_KIND_FWD in btf_dumper_do_type()
- return directly from cases in switch-case and save 9 LOC in
  btf_dumper_do_type()
- remove check for null argument in btf_dumper_type()
- remove header file btf_dumper.h and move declarations to main.h

patch 3:
- change stdint types to kernel equivalents
- keep header includes in alphabetical order
- use goto in do_dump_btf() to ensure jsonw_end_object() in cases of error
- don't initialise variable with functions that can fail in get_btf()
- remove json-breaking printf in get_btf()
- refactor so that there isn't too much code in if (!err) case in do_lookup()

Thanks,
Okash
