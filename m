Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8630EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4223020857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jgs0kghE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4223020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeGZQt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:49:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54004 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731273AbeGZQt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:49:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6QFMMJe005888;
        Thu, 26 Jul 2018 08:32:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=3TrNSnukan3BDMXsKGH3JNaCE1xqkhgu6UASL2iEclU=;
 b=jgs0kghEK63fVny/g54i+P8D+2YoZU1uy4KcncUYxySCCGuq0VPEMo1oWoWynlwmP/Ro
 Uh6w4BNCxdgtvtGrAYujf1R/+SoxvqMKVYTmXY29RgZRMrXICP14ERxLft0FopGDCUc9
 LXg50H6ONGC9oEJrMLB+Gm70reTmQh+maJw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kfgvp8112-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 26 Jul 2018 08:32:13 -0700
Received: from kafai-mbp.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.21) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Thu, 26 Jul 2018 08:32:11 -0700
Date:   Thu, 26 Jul 2018 08:32:07 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Okash Khawaja <osk@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the bpf tree
Message-ID: <20180726153207.6xmtrmprko2cpat6@kafai-mbp.dhcp.thefacebook.com>
References: <20180726111916.47a47dbf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180726111916.47a47dbf@canb.auug.org.au>
User-Agent: NeoMutt/20180512
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-26_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 11:19:16AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got conflicts in:
> 
>   tools/lib/bpf/btf.c
>   tools/lib/bpf/btf.h
> 
> between commits:
> 
>   5b891af7fca1 ("bpf: Replace [u]int32_t and [u]int64_t in libbpf")
>   38d5d3b3d5db ("bpf: Introduce BPF_ANNOTATE_KV_PAIR")
> 
> from the bpf tree and commit:
> 
>   92b57121ca79 ("bpf: btf: export btf types and name by offset from lib")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.  This
The fix LGTM. Thanks!

> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc tools/lib/bpf/btf.c
> index 2d270c560df3,03161be094b4..000000000000
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@@ -269,9 -259,29 +266,29 @@@ __s64 btf__resolve_size(const struct bt
>   	return nelems * size;
>   }
>   
> + int btf__resolve_type(const struct btf *btf, __u32 type_id)
> + {
> + 	const struct btf_type *t;
> + 	int depth = 0;
> + 
> + 	t = btf__type_by_id(btf, type_id);
> + 	while (depth < MAX_RESOLVE_DEPTH &&
> + 	       !btf_type_is_void_or_null(t) &&
> + 	       IS_MODIFIER(BTF_INFO_KIND(t->info))) {
> + 		type_id = t->type;
> + 		t = btf__type_by_id(btf, type_id);
> + 		depth++;
> + 	}
> + 
> + 	if (depth == MAX_RESOLVE_DEPTH || btf_type_is_void_or_null(t))
> + 		return -EINVAL;
> + 
> + 	return type_id;
> + }
> + 
>  -int32_t btf__find_by_name(const struct btf *btf, const char *type_name)
>  +__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
>   {
>  -	uint32_t i;
>  +	__u32 i;
>   
>   	if (!strcmp(type_name, "void"))
>   		return 0;
> @@@ -368,3 -379,20 +385,11 @@@ int btf__fd(const struct btf *btf
>   {
>   	return btf->fd;
>   }
> + 
> + const char *btf__name_by_offset(const struct btf *btf, __u32 offset)
> + {
> + 	if (offset < btf->hdr->str_len)
> + 		return &btf->strings[offset];
> + 	else
> + 		return NULL;
> + }
>  -
>  -const struct btf_type *btf__type_by_id(const struct btf *btf,
>  -				       __u32 type_id)
>  -{
>  -	if (type_id > btf->nr_types)
>  -		return NULL;
>  -
>  -	return btf->types[type_id];
>  -}
> diff --cc tools/lib/bpf/btf.h
> index e2a09a155f84,24f361d99a5e..000000000000
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@@ -15,10 -14,12 +15,12 @@@ typedef int (*btf_print_fn_t)(const cha
>   	__attribute__((format(printf, 1, 2)));
>   
>   void btf__free(struct btf *btf);
>  -struct btf *btf__new(uint8_t *data, uint32_t size, btf_print_fn_t err_log);
>  -int32_t btf__find_by_name(const struct btf *btf, const char *type_name);
>  -int64_t btf__resolve_size(const struct btf *btf, uint32_t type_id);
>  +struct btf *btf__new(__u8 *data, __u32 size, btf_print_fn_t err_log);
>  +__s32 btf__find_by_name(const struct btf *btf, const char *type_name);
> - const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 id);
>  +__s64 btf__resolve_size(const struct btf *btf, __u32 type_id);
> + int btf__resolve_type(const struct btf *btf, __u32 type_id);
>   int btf__fd(const struct btf *btf);
> + const char *btf__name_by_offset(const struct btf *btf, __u32 offset);
> + const struct btf_type *btf__type_by_id(const struct btf *btf, __u32 type_id);
>   
>   #endif


