Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37253C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAD720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GAiN0N8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBAD720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933414AbeFTUjm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:39:42 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46892 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932953AbeFTUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:39:38 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KKblCK015000
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:39:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date : from
 : to : cc : subject : mime-version : content-type; s=facebook;
 bh=7DR9mbcHESY4Fbbi/DeWLc0WHNf0bj5pHSKb36hCzXE=;
 b=GAiN0N8rnhrcDiHP3ki88rC37xG93Of0jE5yNxJL8rQQoAYUoYT0OSnDnwsO4WX67afc
 cSu1FLMThdBdFyQMsQgPe+OSYLJga/77bFb0fdlen36Ey0g1lvnmtGtW1793BwR1S4/q
 qyuts/fiAnIoOROGco1J/+rZ+9VHkK4sY1w= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jqtjp8rp8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:39:38 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.16) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 20 Jun
 2018 13:39:37 -0700
Received: by dev026.lla1.facebook.com (Postfix, from userid 152872)     id
 F1D5E8A1905; Wed, 20 Jun 2018 13:37:02 -0700 (PDT)
Message-ID: <20180620203051.223156973@fb.com>
User-Agent: quilt/0.63-1
Date:   Wed, 20 Jun 2018 13:30:51 -0700
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
Subject: [PATCH bpf-next 0/3] bpf: btf: json print btf info with bpftool map dump
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches augment the bpftool's map dump command with BTF info. In
particular, when user runs `bpftool map dump [-j|-p] id <map-id>`, they will
see map data formatted and tagged based upon BTF information associated with
that map. Here is what each patch does:

Patch 1 exports BTF functions inside libbpf, to be used by patch 2.

Patch 2 adds btf_dumper which uses type info exported in patch 1 along
with json_writer to json print or pretty json print map values alongside
btf debug info.

Patch 3 uses btf_dumper to json or pretty print map values when -j or -p
flag is specified to `btf map dump`.

Further details are included in patch descriptions.

Thanks,
Okash
