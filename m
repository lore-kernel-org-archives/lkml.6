Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991FBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C39C21528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NT75Fw/L";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PlKzi/+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C39C21528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeIZW2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:28:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43744 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbeIZW2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:28:12 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w8QGAgjr013205;
        Wed, 26 Sep 2018 09:14:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MjOVJWlPU4pp9cS3V/hiMyIQxB7BrOYimV9Xjz9QczU=;
 b=NT75Fw/L93bdArn5i0nVvE9Paf9T5WxP92s43gsP6+VFr1XggHinWy/9cRiVi3OKBW36
 6FOBAc5WZHaX8C6m4QG9+Yquf7Vicz1TpLrgUF3dStnUwUwA0hthPWtyS19X5MC9mMGt
 a/2QuW3k89uoHkW2Fg6/XRwOeaNaY3dvlHk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2mrb32rkh5-5
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 09:14:10 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 12:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjOVJWlPU4pp9cS3V/hiMyIQxB7BrOYimV9Xjz9QczU=;
 b=PlKzi/+bSvBBF/rwkqH0DDbU42l6MaiaMZnV5d6oshw0zseHFbIeRD1JTDxYfuVx4eErUDt8fxE+4+daWa39StQ43lqIHEfLiEeMBMGDKoBANYEtoESEh+izMOEtF91oUANPLgOjnIKjE3kQzlrF+29hSHDtxmizNxhjeowh1qU=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1710.namprd15.prod.outlook.com (10.174.254.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 26 Sep 2018 16:13:40 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705%7]) with mapi id 15.20.1143.019; Wed, 26 Sep 2018
 16:13:40 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Roman Gushchin <guro@fb.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
Thread-Topic: [PATCH v3 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
Thread-Index: AQHUVYzPfRCdDRaBdkOf9SK+t1NSFaUCvKuA
Date:   Wed, 26 Sep 2018 16:13:40 +0000
Message-ID: <D7D7DF96-92E6-4A58-B342-62359846EFC1@fb.com>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-4-guro@fb.com>
In-Reply-To: <20180926113326.29069-4-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:200::4:1387]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1710;20:ADcH53QaP2PTTBlE+M0COnLtx4T8SOie1QqlZml2WfcTEijsrDWEG0yjsrQEGOF2ceREu8NEDCj3j/ARsdOAnVxbo4NchO+8khm3njKTN33xJPhwrdtSWrhyILVqQkp8NMiSm5Wkbsie8JJjRs9RwTdUm8HWlYegNViP0yIYCnM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: d474f695-b2ca-405b-fa5b-08d623cb0611
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1710;
x-ms-traffictypediagnostic: MWHPR15MB1710:
x-microsoft-antispam-prvs: <MWHPR15MB171092CFFA17F6C4454F76B9B3150@MWHPR15MB1710.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:MWHPR15MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1710;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(86362001)(46003)(99286004)(316002)(54906003)(37006003)(6436002)(6512007)(6486002)(229853002)(97736004)(71190400001)(14444005)(71200400001)(106356001)(83716004)(57306001)(105586002)(5660300001)(256004)(4326008)(6862004)(6636002)(6246003)(25786009)(8676002)(2906002)(50226002)(478600001)(11346002)(5250100002)(446003)(8936002)(486006)(53546011)(68736007)(6506007)(53936002)(81156014)(14454004)(81166006)(305945005)(53946003)(36756003)(82746002)(7736002)(575784001)(2616005)(6116002)(33656002)(476003)(2900100001)(102836004)(76176011)(34290500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1710;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: upeZlor93gr8wI3SsWmZ9qka/N9XoQI8kWdeMUE2oCLdkXrlaCJ1ZwpeAQgzEjl3tE+MN2GeZGiqHSeGDMX++a9rYnbNjaxbxuDYlviCBjfVHsmzhKSSuiSMP0rlAE40e8lMLZn677l6NTsU4a7VbZ9w0q5A4fXRAVNPUFsobXzZ1Ohe8Pd9gmBgt43JrI0jtpgmm6MtnfTL1cPDjjBBbPF3r/ZCsa0qe06zzuWXP6NoINpvwHFogViYYKgGwxDjtN5vLkPRGJF5vIeDXHX7fYcdjmN08RwQbUTyXY//rLAdxd2hBV14OWBcH8dNIJLg3Gpu/ctgjEtaP6d4t8XKyTY5RC8hHI18mhqgEePZBRQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2A2DF1FA9D90C4FA3AB03BD501CEB8A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d474f695-b2ca-405b-fa5b-08d623cb0611
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 16:13:40.4556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 26, 2018, at 4:33 AM, Roman Gushchin <guro@fb.com> wrote:
>=20
> This commit introduced per-cpu cgroup local storage.
>=20
> Per-cpu cgroup local storage is very similar to simple cgroup storage
> (let's call it shared), except all the data is per-cpu.
>=20
> The main goal of per-cpu variant is to implement super fast
> counters (e.g. packet counters), which don't require neither
> lookups, neither atomic operations.
>=20
> From userspace's point of view, accessing a per-cpu cgroup storage
> is similar to other per-cpu map types (e.g. per-cpu hashmaps and
> arrays).
>=20
> Writing to a per-cpu cgroup storage is not atomic, but is performed
> by copying longs, so some minimal atomicity is here, exactly
> as with other per-cpu maps.
>=20
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> include/linux/bpf-cgroup.h |  20 ++++-
> include/linux/bpf.h        |   1 +
> include/linux/bpf_types.h  |   1 +
> include/uapi/linux/bpf.h   |   1 +
> kernel/bpf/helpers.c       |   8 +-
> kernel/bpf/local_storage.c | 148 ++++++++++++++++++++++++++++++++-----
> kernel/bpf/syscall.c       |  11 ++-
> kernel/bpf/verifier.c      |  15 +++-
> 8 files changed, 177 insertions(+), 28 deletions(-)
>=20
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 7e0c9a1d48b7..588dd5f0bd85 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -37,7 +37,10 @@ struct bpf_storage_buffer {
> };
>=20
> struct bpf_cgroup_storage {
> -	struct bpf_storage_buffer *buf;
> +	union {
> +		struct bpf_storage_buffer *buf;
> +		void __percpu *percpu_buf;
> +	};
> 	struct bpf_cgroup_storage_map *map;
> 	struct bpf_cgroup_storage_key key;
> 	struct list_head list;
> @@ -109,6 +112,9 @@ int __cgroup_bpf_check_dev_permission(short dev_type,=
 u32 major, u32 minor,
> static inline enum bpf_cgroup_storage_type cgroup_storage_type(
> 	struct bpf_map *map)
> {
> +	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> +		return BPF_CGROUP_STORAGE_PERCPU;
> +
> 	return BPF_CGROUP_STORAGE_SHARED;
> }
>=20
> @@ -131,6 +137,10 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_sto=
rage *storage);
> int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *map)=
;
> void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *ma=
p);
>=20
> +int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, void =
*value);
> +int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
> +				     void *value, u64 flags);
> +
> /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabl=
ed. */
> #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
> ({									      \
> @@ -285,6 +295,14 @@ static inline struct bpf_cgroup_storage *bpf_cgroup_=
storage_alloc(
> 	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0; }
> static inline void bpf_cgroup_storage_free(
> 	struct bpf_cgroup_storage *storage) {}
> +static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, vo=
id *key,
> +						 void *value) {
> +	return 0;
> +}
> +static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
> +					void *key, void *value, u64 flags) {
> +	return 0;
> +}
>=20
> #define cgroup_bpf_enabled (0)
> #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b457fbe7b70b..018299a595c8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -274,6 +274,7 @@ struct bpf_prog_offload {
>=20
> enum bpf_cgroup_storage_type {
> 	BPF_CGROUP_STORAGE_SHARED,
> +	BPF_CGROUP_STORAGE_PERCPU,
> 	__BPF_CGROUP_STORAGE_MAX
> };
>=20
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index c9bd6fb765b0..5432f4c9f50e 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -43,6 +43,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_ma=
p_ops)
> #endif
> #ifdef CONFIG_CGROUP_BPF
> BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
> +BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_ops)
> #endif
> BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
> BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index aa5ccd2385ed..e2070d819e04 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -127,6 +127,7 @@ enum bpf_map_type {
> 	BPF_MAP_TYPE_SOCKHASH,
> 	BPF_MAP_TYPE_CGROUP_STORAGE,
> 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> +	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> };
>=20
> enum bpf_prog_type {
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e42f8789b7ea..6502115e8f55 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -206,10 +206,16 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map *,=
 map, u64, flags)
> 	 */
> 	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(map);
> 	struct bpf_cgroup_storage *storage;
> +	void *ptr;
>=20
> 	storage =3D this_cpu_read(bpf_cgroup_storage[stype]);
>=20
> -	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
> +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
> +		ptr =3D &READ_ONCE(storage->buf)->data[0];
> +	else
> +		ptr =3D this_cpu_ptr(storage->percpu_buf);
> +
> +	return (unsigned long)ptr;
> }
>=20
> const struct bpf_func_proto bpf_get_local_storage_proto =3D {
> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 6742292fb39e..c739f6dcc3c2 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -152,6 +152,71 @@ static int cgroup_storage_update_elem(struct bpf_map=
 *map, void *_key,
> 	return 0;
> }
>=20
> +int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
> +				   void *value)
> +{
> +	struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
> +	struct bpf_cgroup_storage_key *key =3D _key;
> +	struct bpf_cgroup_storage *storage;
> +	int cpu, off =3D 0;
> +	u32 size;
> +
> +	rcu_read_lock();
> +	storage =3D cgroup_storage_lookup(map, key, false);
> +	if (!storage) {
> +		rcu_read_unlock();
> +		return -ENOENT;
> +	}
> +
> +	/* per_cpu areas are zero-filled and bpf programs can only
> +	 * access 'value_size' of them, so copying rounded areas
> +	 * will not leak any kernel data
> +	 */
> +	size =3D round_up(_map->value_size, 8);
> +	for_each_possible_cpu(cpu) {
> +		bpf_long_memcpy(value + off,
> +				per_cpu_ptr(storage->percpu_buf, cpu), size);
> +		off +=3D size;
> +	}
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
> +				     void *value, u64 map_flags)
> +{
> +	struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
> +	struct bpf_cgroup_storage_key *key =3D _key;
> +	struct bpf_cgroup_storage *storage;
> +	int cpu, off =3D 0;
> +	u32 size;
> +
> +	if (unlikely(map_flags & BPF_EXIST))
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +	storage =3D cgroup_storage_lookup(map, key, false);
> +	if (!storage) {
> +		rcu_read_unlock();
> +		return -ENOENT;
> +	}
> +
> +	/* the user space will provide round_up(value_size, 8) bytes that
> +	 * will be copied into per-cpu area. bpf programs can only access
> +	 * value_size of it. During lookup the same extra bytes will be
> +	 * returned or zeros which were zero-filled by percpu_alloc,
> +	 * so no kernel data leaks possible
> +	 */
> +	size =3D round_up(_map->value_size, 8);
> +	for_each_possible_cpu(cpu) {
> +		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
> +				value + off, size);
> +		off +=3D size;
> +	}
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key,
> 				       void *_next_key)
> {
> @@ -292,55 +357,98 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_alloc=
(struct bpf_prog *prog,
> {
> 	struct bpf_cgroup_storage *storage;
> 	struct bpf_map *map;
> +	gfp_t flags;
> +	size_t size;
> 	u32 pages;
>=20
> 	map =3D prog->aux->cgroup_storage[stype];
> 	if (!map)
> 		return NULL;
>=20
> -	pages =3D round_up(sizeof(struct bpf_cgroup_storage) +
> -			 sizeof(struct bpf_storage_buffer) +
> -			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
> +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
> +		size =3D sizeof(struct bpf_storage_buffer) + map->value_size;
> +		pages =3D round_up(sizeof(struct bpf_cgroup_storage) + size,
> +				 PAGE_SIZE) >> PAGE_SHIFT;
> +	} else {
> +		size =3D map->value_size;
> +		pages =3D round_up(round_up(size, 8) * num_possible_cpus(),
> +				 PAGE_SIZE) >> PAGE_SHIFT;
> +	}
> +
> 	if (bpf_map_charge_memlock(map, pages))
> 		return ERR_PTR(-EPERM);
>=20
> 	storage =3D kmalloc_node(sizeof(struct bpf_cgroup_storage),
> 			       __GFP_ZERO | GFP_USER, map->numa_node);
> -	if (!storage) {
> -		bpf_map_uncharge_memlock(map, pages);
> -		return ERR_PTR(-ENOMEM);
> -	}
> +	if (!storage)
> +		goto enomem;
>=20
> -	storage->buf =3D kmalloc_node(sizeof(struct bpf_storage_buffer) +
> -				    map->value_size, __GFP_ZERO | GFP_USER,
> -				    map->numa_node);
> -	if (!storage->buf) {
> -		bpf_map_uncharge_memlock(map, pages);
> -		kfree(storage);
> -		return ERR_PTR(-ENOMEM);
> +	flags =3D __GFP_ZERO | GFP_USER;
> +
> +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
> +		storage->buf =3D kmalloc_node(size, flags, map->numa_node);
> +		if (!storage->buf)
> +			goto enomem;
> +	} else {
> +		storage->percpu_buf =3D __alloc_percpu_gfp(size, 8, flags);
> +		if (!storage->percpu_buf)
> +			goto enomem;
> 	}
>=20
> 	storage->map =3D (struct bpf_cgroup_storage_map *)map;
>=20
> 	return storage;
> +
> +enomem:
> +	bpf_map_uncharge_memlock(map, pages);
> +	kfree(storage);
> +	return ERR_PTR(-ENOMEM);
> +}
> +
> +static void free_shared_cgroup_storage_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_cgroup_storage *storage =3D
> +		container_of(rcu, struct bpf_cgroup_storage, rcu);
> +
> +	kfree(storage->buf);
> +	kfree(storage);
> +}
> +
> +static void free_percpu_cgroup_storage_rcu(struct rcu_head *rcu)
> +{
> +	struct bpf_cgroup_storage *storage =3D
> +		container_of(rcu, struct bpf_cgroup_storage, rcu);
> +
> +	free_percpu(storage->percpu_buf);
> +	kfree(storage);
> }
>=20
> void bpf_cgroup_storage_free(struct bpf_cgroup_storage *storage)
> {
> -	u32 pages;
> +	enum bpf_cgroup_storage_type stype;
> 	struct bpf_map *map;
> +	u32 pages;
>=20
> 	if (!storage)
> 		return;
>=20
> 	map =3D &storage->map->map;
> -	pages =3D round_up(sizeof(struct bpf_cgroup_storage) +
> -			 sizeof(struct bpf_storage_buffer) +
> -			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
> +	stype =3D cgroup_storage_type(map);
> +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
> +		pages =3D round_up(sizeof(struct bpf_cgroup_storage) +
> +				 sizeof(struct bpf_storage_buffer) +
> +				 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
> +	else
> +		pages =3D round_up(round_up(map->value_size, 8) *
> +				 num_possible_cpus(),
> +				 PAGE_SIZE) >> PAGE_SHIFT;
> +
> 	bpf_map_uncharge_memlock(map, pages);
>=20
> -	kfree_rcu(storage->buf, rcu);
> -	kfree_rcu(storage, rcu);
> +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
> +		call_rcu(&storage->rcu, free_shared_cgroup_storage_rcu);
> +	else
> +		call_rcu(&storage->rcu, free_percpu_cgroup_storage_rcu);
> }
>=20
> void bpf_cgroup_storage_link(struct bpf_cgroup_storage *storage,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8c91d2b41b1e..5742df21598c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -686,7 +686,8 @@ static int map_lookup_elem(union bpf_attr *attr)
>=20
> 	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> 	    map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> -	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> +	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> 		value_size =3D round_up(map->value_size, 8) * num_possible_cpus();
> 	else if (IS_FD_MAP(map))
> 		value_size =3D sizeof(u32);
> @@ -705,6 +706,8 @@ static int map_lookup_elem(union bpf_attr *attr)
> 		err =3D bpf_percpu_hash_copy(map, key, value);
> 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
> 		err =3D bpf_percpu_array_copy(map, key, value);
> +	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
> +		err =3D bpf_percpu_cgroup_storage_copy(map, key, value);
> 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_STACK_TRACE) {
> 		err =3D bpf_stackmap_copy(map, key, value);
> 	} else if (IS_FD_ARRAY(map)) {
> @@ -774,7 +777,8 @@ static int map_update_elem(union bpf_attr *attr)
>=20
> 	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
> 	    map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
> -	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY ||
> +	    map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> 		value_size =3D round_up(map->value_size, 8) * num_possible_cpus();
> 	else
> 		value_size =3D map->value_size;
> @@ -809,6 +813,9 @@ static int map_update_elem(union bpf_attr *attr)
> 		err =3D bpf_percpu_hash_update(map, key, value, attr->flags);
> 	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
> 		err =3D bpf_percpu_array_update(map, key, value, attr->flags);
> +	} else if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
> +		err =3D bpf_percpu_cgroup_storage_update(map, key, value,
> +						       attr->flags);
> 	} else if (IS_FD_ARRAY(map)) {
> 		rcu_read_lock();
> 		err =3D bpf_fd_array_map_update_elem(map, f.file, key, value,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e90899df585d..a8cc83a970d1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2074,6 +2074,7 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
> 			goto error;
> 		break;
> 	case BPF_MAP_TYPE_CGROUP_STORAGE:
> +	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
> 		if (func_id !=3D BPF_FUNC_get_local_storage)
> 			goto error;
> 		break;
> @@ -2164,7 +2165,8 @@ static int check_map_func_compatibility(struct bpf_=
verifier_env *env,
> 			goto error;
> 		break;
> 	case BPF_FUNC_get_local_storage:
> -		if (map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE)
> +		if (map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE &&
> +		    map->map_type !=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> 			goto error;
> 		break;
> 	case BPF_FUNC_sk_select_reuseport:
> @@ -5049,6 +5051,12 @@ static int check_map_prog_compatibility(struct bpf=
_verifier_env *env,
> 	return 0;
> }
>=20
> +static bool bpf_map_is_cgroup_storage(struct bpf_map *map)
> +{
> +	return (map->map_type =3D=3D BPF_MAP_TYPE_CGROUP_STORAGE ||
> +		map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE);
> +}
> +
> /* look for pseudo eBPF instructions that access map FDs and
>  * replace them with actual map pointers
>  */
> @@ -5139,10 +5147,9 @@ static int replace_map_fd_with_map_ptr(struct bpf_=
verifier_env *env)
> 			}
> 			env->used_maps[env->used_map_cnt++] =3D map;
>=20
> -			if (map->map_type =3D=3D BPF_MAP_TYPE_CGROUP_STORAGE &&
> +			if (bpf_map_is_cgroup_storage(map) &&
> 			    bpf_cgroup_storage_assign(env->prog, map)) {
> -				verbose(env,
> -					"only one cgroup storage is allowed\n");
> +				verbose(env, "only one cgroup storage of each type is allowed\n");
> 				fdput(f);
> 				return -EBUSY;
> 			}
> --=20
> 2.17.1
>=20

