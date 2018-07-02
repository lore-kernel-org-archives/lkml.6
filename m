Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEFFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CD024F68
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hvYKr6mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CD024F68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeGBTQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:16:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34348 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752639AbeGBTQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:16:23 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62JEveX011901
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 12:16:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : mime-version : content-type; s=facebook;
 bh=/FDWNq5W1LM6JOQKxAVnlmXl8mUoDZtczhm1mLEx2Hk=;
 b=hvYKr6muQVYMMpp10t+mMEfKk89t470CxZAKBuiQQnhtLjr1Qcy4OhLl1756vmZl3xAQ
 rYqNP3ilaZXiXRUbGnAFktwlp5KdvwPaSqzrBfw9PxsbXXHdrUsUMXdDRxYPO+fEWYVv
 DrRoIpFsYJnHIIdVs0YMrez0cKPfdGvshK0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jyq8nrg9e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 12:16:23 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.14) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 2 Jul
 2018 12:16:22 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 725948A245B; Mon,  2 Jul 2018 12:13:24 -0700 (PDT)
Message-ID: <20180702183913.669030439@fb.com>
User-Agent: quilt/0.63-1
Date:   Mon, 2 Jul 2018 11:39:13 -0700
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
Subject: [PATCH bpf-next v2 0/3] bpf: btf: print bpftool map data with btf
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2. There are two key changes which mostly affect patches 2 and 3.
First, we have two BTF outputs:

1. when -j or -p switches are supplied to a map command - this is json- and
backward- compatible
2. when neither of -j and -p is supplied - this makes no promises on json- or
backward- compatibility, and aimed for humans

Second, in addition to map dump command, map lookup command has also been
updated to print data with btf. The rules around -j and -p are same as above.

Here is a summary of changes in v2:

patch 1:
    - line continuation alignment fixes + other style fixes

patch 2:
    - introduce struct btf_dumper which contains context for btf_dumper operation
    - line continuation alignment fixes + other style fixes
    - fix SPDX licence comment style to be C++ style
    - reverse christmas tree style comments
    - in btf_dumper_array() ensure we end json_writer array in case of error

patch 3:
    - btf output for humans is shown when neither -j nor -p is supplied
    - when -j or -p are supplied, augment output with "formatted" object which shows btf data in json
    - added btf output to map lookup command also
    - declarations to follow reverse christmas tree style
    - error message grammar fix and remove full stop
    - line continuation alignment fixes + other style fixes
    - reorganise do_dump_btf() to remove goto and make it clearer
    - remove misleading comment about end of root json object
    - add comment to explain allocation btf buffer
    - brackets around else clause to harmonise with braces on if clause

Thanks,
Okash
