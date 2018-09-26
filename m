Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB42C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005DD2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="S670xxCM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IKzIZpoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005DD2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeIZOyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:54:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbeIZOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:54:53 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q8gT6Q006666;
        Wed, 26 Sep 2018 01:42:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EiEeobEIXYMWRNd0hU4aqVQ8ACjkxGLHSAzI+xTMUoA=;
 b=S670xxCMsyETTQN38Sn4/ANIoAhSWJxz6OGAk4UMZsTE49CCzTt60M4k4EGNPmGIZ5Vj
 4pELxkFGjadUGntbkXJSiCUHIPtyEg1vFxp5bPKXwshlUF94r9VQSERCr0bvbQEFrksB
 HYl/8ZAgLmJzJ7IKs4xJRzCnizv6WGWbxCA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mr4vc08wj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 26 Sep 2018 01:42:29 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.34) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 26 Sep 2018 04:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiEeobEIXYMWRNd0hU4aqVQ8ACjkxGLHSAzI+xTMUoA=;
 b=IKzIZpoFp+/3HqjkbttJ5P8piVQbqabGWO3Q49stO+bBXPQXVGUGeeLl8XIOsdPD2QPJeuwZr7OzNMwjx+/vcLcp5TpV2wdLflOeeWtJJ/v1SiLmIsOg7pcQCt3yDJF6Q+fceS+HxrIC4OrFqOg91gCewqM0gazw/3APu7P+FFY=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0293.namprd15.prod.outlook.com (10.163.64.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Wed, 26 Sep 2018 08:42:24 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::5c5b:75ea:cae:1e68%2]) with mapi id 15.20.1164.024; Wed, 26 Sep 2018
 08:42:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Song Liu <songliubraving@fb.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Alexei Starovoitov" <ast@kernel.org>
Subject: Re: [PATCH v2 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
Thread-Topic: [PATCH v2 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
Thread-Index: AQHUVON1E8pCEF1/JECo0iVDuPhpQ6UBWJ2AgADnQoA=
Date:   Wed, 26 Sep 2018 08:42:23 +0000
Message-ID: <20180926084208.GA25056@castle.DHCP.thefacebook.com>
References: <20180925152114.13537-1-guro@fb.com>
 <20180925152114.13537-4-guro@fb.com>
 <27B81458-17C5-4840-9679-D1F5FBF6E805@fb.com>
In-Reply-To: <27B81458-17C5-4840-9679-D1F5FBF6E805@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:206:1::25) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c092:200::1:4d7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0293;20:2QqD7XTGoq3jRgLarlFAel2aWtGQU6fbq3chtHoJFD3O9d4hOmN/caHFPPWPPH8urGl6EWjBdHN2cOR7cdsnB5+rYKpWs08KWTxAzzrTrZHyLb27iBPSydNaT/477bXKrcPo6CO10qRe5aXaRdRq/niW2K/dGDkQ9c0/Kdpy2aE=
x-ms-office365-filtering-correlation-id: 92cb4626-7273-40d2-edc3-08d6238bfa35
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0293;
x-ms-traffictypediagnostic: BY2PR15MB0293:
x-microsoft-antispam-prvs: <BY2PR15MB0293C790169A018EC2828F72BE150@BY2PR15MB0293.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BY2PR15MB0293;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0293;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(39860400002)(366004)(199004)(189003)(102836004)(5250100002)(76176011)(476003)(71190400001)(34290500001)(71200400001)(478600001)(486006)(446003)(11346002)(54906003)(305945005)(52116002)(46003)(33896004)(316002)(575784001)(86362001)(99286004)(7736002)(2906002)(6246003)(68736007)(2900100001)(14444005)(6116002)(53546011)(1076002)(5660300001)(6862004)(4326008)(97736004)(256004)(6436002)(6512007)(9686003)(14454004)(53936002)(386003)(25786009)(229853002)(6486002)(6506007)(33656002)(6636002)(105586002)(8676002)(81166006)(81156014)(8936002)(106356001)(345774005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0293;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jzgJEHI+PrT0tYmY+++XI3ZJm6zutaxMp77jGJDwT2ATWEZEhYLWW0wIg6OAFkHCqglx7vXag/tFx86ylZpdsicBXZpiGaIwPAxHjsBbtUp7W6V9qM5JauF6PQfvWfeJpMBDRZAKmjjBZlSD2Wd74bpduE63xoraiuCBH9sPpUbqZyknuFxdriIsOK+6+vIW51i09wOKG2FeGEJGrX2pgkk0HQ6hwaaIvklze5MGl2folVeIVpZiyxSsPZoX2NamuVr+UKbqlG4Id8PcUma7mZupBfNl0XE0Nb/ceFi8KUhY8YWChj037cNi9ZQyQ9WD1XZ3GO/3j+UPYnx90oP1CDwgNwTD7u8OtkEHLCY4edY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C382D34973B104A9A8F4662F2DD006B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cb4626-7273-40d2-edc3-08d6238bfa35
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 08:42:23.9111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0293
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:54:33AM -0700, Song Liu wrote:
>=20
>=20
> > On Sep 25, 2018, at 8:21 AM, Roman Gushchin <guro@fb.com> wrote:
> >=20
> > This commit introduced per-cpu cgroup local storage.
> >=20
> > Per-cpu cgroup local storage is very similar to simple cgroup storage
> > (let's call it shared), except all the data is per-cpu.
> >=20
> > The main goal of per-cpu variant is to implement super fast
> > counters (e.g. packet counters), which don't require neither
> > lookups, neither atomic operations.
> >=20
> > From userspace's point of view, accessing a per-cpu cgroup storage
> > is similar to other per-cpu map types (e.g. per-cpu hashmaps and
> > arrays).
> >=20
> > Writing to a per-cpu cgroup storage is not atomic, but is performed
> > by copying longs, so some minimal atomicity is here, exactly
> > as with other per-cpu maps.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > ---
> > include/linux/bpf-cgroup.h |  20 ++++-
> > include/linux/bpf.h        |   1 +
> > include/linux/bpf_types.h  |   1 +
> > include/uapi/linux/bpf.h   |   1 +
> > kernel/bpf/helpers.c       |   8 +-
> > kernel/bpf/local_storage.c | 148 ++++++++++++++++++++++++++++++++-----
> > kernel/bpf/syscall.c       |  11 ++-
> > kernel/bpf/verifier.c      |  15 +++-
> > 8 files changed, 177 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> > index 7e0c9a1d48b7..9bd907657f9b 100644
> > --- a/include/linux/bpf-cgroup.h
> > +++ b/include/linux/bpf-cgroup.h
> > @@ -37,7 +37,10 @@ struct bpf_storage_buffer {
> > };
> >=20
> > struct bpf_cgroup_storage {
> > -	struct bpf_storage_buffer *buf;
> > +	union {
> > +		struct bpf_storage_buffer *buf;
> > +		char __percpu *percpu_buf;
>=20
> "char *" here looks weird. Did you mean to use "void *"?

Fair enough. It's probably a leftover from (previously used) char[0].

>=20
> > +	};
> > 	struct bpf_cgroup_storage_map *map;
> > 	struct bpf_cgroup_storage_key key;
> > 	struct list_head list;
> > @@ -109,6 +112,9 @@ int __cgroup_bpf_check_dev_permission(short dev_typ=
e, u32 major, u32 minor,
> > static inline enum bpf_cgroup_storage_type cgroup_storage_type(
> > 	struct bpf_map *map)
> > {
> > +	if (map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> > +		return BPF_CGROUP_STORAGE_PERCPU;
> > +
> > 	return BPF_CGROUP_STORAGE_SHARED;
> > }
> >=20
> > @@ -131,6 +137,10 @@ void bpf_cgroup_storage_unlink(struct bpf_cgroup_s=
torage *storage);
> > int bpf_cgroup_storage_assign(struct bpf_prog *prog, struct bpf_map *ma=
p);
> > void bpf_cgroup_storage_release(struct bpf_prog *prog, struct bpf_map *=
map);
> >=20
> > +int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, void *key, voi=
d *value);
> > +int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
> > +				     void *value, u64 flags);
> > +
> > /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_ena=
bled. */
> > #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
> > ({									      \
> > @@ -285,6 +295,14 @@ static inline struct bpf_cgroup_storage *bpf_cgrou=
p_storage_alloc(
> > 	struct bpf_prog *prog, enum bpf_cgroup_storage_type stype) { return 0;=
 }
> > static inline void bpf_cgroup_storage_free(
> > 	struct bpf_cgroup_storage *storage) {}
> > +static inline int bpf_percpu_cgroup_storage_copy(struct bpf_map *map, =
void *key,
> > +						 void *value) {
> > +	return 0;
> > +}
> > +static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map=
,
> > +					void *key, void *value, u64 flags) {
> > +	return 0;
> > +}
> >=20
> > #define cgroup_bpf_enabled (0)
> > #define BPF_CGROUP_PRE_CONNECT_ENABLED(sk) (0)
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index b457fbe7b70b..018299a595c8 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -274,6 +274,7 @@ struct bpf_prog_offload {
> >=20
> > enum bpf_cgroup_storage_type {
> > 	BPF_CGROUP_STORAGE_SHARED,
> > +	BPF_CGROUP_STORAGE_PERCPU,
> > 	__BPF_CGROUP_STORAGE_MAX
> > };
> >=20
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index c9bd6fb765b0..5432f4c9f50e 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -43,6 +43,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_ARRAY, cgroup_array_=
map_ops)
> > #endif
> > #ifdef CONFIG_CGROUP_BPF
> > BPF_MAP_TYPE(BPF_MAP_TYPE_CGROUP_STORAGE, cgroup_storage_map_ops)
> > +BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE, cgroup_storage_map_op=
s)
> > #endif
> > BPF_MAP_TYPE(BPF_MAP_TYPE_HASH, htab_map_ops)
> > BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_HASH, htab_percpu_map_ops)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index aa5ccd2385ed..e2070d819e04 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -127,6 +127,7 @@ enum bpf_map_type {
> > 	BPF_MAP_TYPE_SOCKHASH,
> > 	BPF_MAP_TYPE_CGROUP_STORAGE,
> > 	BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> > +	BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> > };
> >=20
> > enum bpf_prog_type {
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index e42f8789b7ea..1f21ef1c4ad3 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -206,10 +206,16 @@ BPF_CALL_2(bpf_get_local_storage, struct bpf_map =
*, map, u64, flags)
> > 	 */
> > 	enum bpf_cgroup_storage_type stype =3D cgroup_storage_type(map);
> > 	struct bpf_cgroup_storage *storage;
> > +	void *ptr =3D NULL;
>=20
> Not necessary to initialize to NULL.

Fixed.

>=20
> >=20
> > 	storage =3D this_cpu_read(bpf_cgroup_storage[stype]);
> >=20
> > -	return (unsigned long)&READ_ONCE(storage->buf)->data[0];
> > +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED)
> > +		ptr =3D &READ_ONCE(storage->buf)->data[0];
> > +	else
> > +		ptr =3D this_cpu_ptr(storage->percpu_buf);
> > +
> > +	return (unsigned long)ptr;
> > }
> >=20
> > const struct bpf_func_proto bpf_get_local_storage_proto =3D {
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index 6742292fb39e..d991355b5b46 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> > @@ -152,6 +152,71 @@ static int cgroup_storage_update_elem(struct bpf_m=
ap *map, void *_key,
> > 	return 0;
> > }
> >=20
> > +int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *_key,
> > +				   void *value)
> > +{
> > +	struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
> > +	struct bpf_cgroup_storage_key *key =3D _key;
> > +	struct bpf_cgroup_storage *storage;
> > +	int cpu, off =3D 0;
> > +	u32 size;
> > +
> > +	rcu_read_lock();
> > +	storage =3D cgroup_storage_lookup(map, key, false);
> > +	if (!storage) {
> > +		rcu_read_unlock();
> > +		return -ENOENT;
> > +	}
> > +
> > +	/* per_cpu areas are zero-filled and bpf programs can only
> > +	 * access 'value_size' of them, so copying rounded areas
> > +	 * will not leak any kernel data
> > +	 */
> > +	size =3D round_up(_map->value_size, 8);
> > +	for_each_possible_cpu(cpu) {
> > +		bpf_long_memcpy(value + off,
> > +				per_cpu_ptr(storage->percpu_buf, cpu), size);
> > +		off +=3D size;
> > +	}
> > +	rcu_read_unlock();
> > +	return 0;
> > +}
> > +
> > +int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *_key,
> > +				     void *value, u64 map_flags)
> > +{
> > +	struct bpf_cgroup_storage_map *map =3D map_to_storage(_map);
> > +	struct bpf_cgroup_storage_key *key =3D _key;
> > +	struct bpf_cgroup_storage *storage;
> > +	int cpu, off =3D 0;
> > +	u32 size;
> > +
> > +	if (unlikely(map_flags & BPF_EXIST))
> > +		return -EINVAL;
> > +
> > +	rcu_read_lock();
> > +	storage =3D cgroup_storage_lookup(map, key, false);
> > +	if (!storage) {
> > +		rcu_read_unlock();
> > +		return -ENOENT;
> > +	}
> > +
> > +	/* the user space will provide round_up(value_size, 8) bytes that
> > +	 * will be copied into per-cpu area. bpf programs can only access
> > +	 * value_size of it. During lookup the same extra bytes will be
> > +	 * returned or zeros which were zero-filled by percpu_alloc,
> > +	 * so no kernel data leaks possible
> > +	 */
> > +	size =3D round_up(_map->value_size, 8);
> > +	for_each_possible_cpu(cpu) {
> > +		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
> > +				value + off, size);
> > +		off +=3D size;
> > +	}
> > +	rcu_read_unlock();
> > +	return 0;
> > +}
> > +
> > static int cgroup_storage_get_next_key(struct bpf_map *_map, void *_key=
,
> > 				       void *_next_key)
> > {
> > @@ -292,55 +357,98 @@ struct bpf_cgroup_storage *bpf_cgroup_storage_all=
oc(struct bpf_prog *prog,
> > {
> > 	struct bpf_cgroup_storage *storage;
> > 	struct bpf_map *map;
> > +	gfp_t flags;
> > +	size_t size;
> > 	u32 pages;
> >=20
> > 	map =3D prog->aux->cgroup_storage[stype];
> > 	if (!map)
> > 		return NULL;
> >=20
> > -	pages =3D round_up(sizeof(struct bpf_cgroup_storage) +
> > -			 sizeof(struct bpf_storage_buffer) +
> > -			 map->value_size, PAGE_SIZE) >> PAGE_SHIFT;
> > +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
> > +		size =3D sizeof(struct bpf_storage_buffer) + map->value_size;
> > +		pages =3D round_up(sizeof(struct bpf_cgroup_storage) + size,
> > +				 PAGE_SIZE) >> PAGE_SHIFT;
> > +	} else {
> > +		size =3D map->value_size;
> > +		pages =3D round_up(round_up(size, 8) * num_possible_cpus(),
> > +				 PAGE_SIZE) >> PAGE_SHIFT;
> > +	}
> > +
> > 	if (bpf_map_charge_memlock(map, pages))
> > 		return ERR_PTR(-EPERM);
> >=20
> > 	storage =3D kmalloc_node(sizeof(struct bpf_cgroup_storage),
> > 			       __GFP_ZERO | GFP_USER, map->numa_node);
> > -	if (!storage) {
> > -		bpf_map_uncharge_memlock(map, pages);
> > -		return ERR_PTR(-ENOMEM);
> > -	}
> > +	if (!storage)
> > +		goto enomem;
> >=20
> > -	storage->buf =3D kmalloc_node(sizeof(struct bpf_storage_buffer) +
> > -				    map->value_size, __GFP_ZERO | GFP_USER,
> > -				    map->numa_node);
> > -	if (!storage->buf) {
> > -		bpf_map_uncharge_memlock(map, pages);
> > -		kfree(storage);
> > -		return ERR_PTR(-ENOMEM);
> > +	flags =3D __GFP_ZERO | GFP_USER;
> > +
> > +	if (stype =3D=3D BPF_CGROUP_STORAGE_SHARED) {
> > +		storage->buf =3D kmalloc_node(size, flags, map->numa_node);
> > +		if (!storage->buf)
> > +			goto enomem;
> > +	} else {
> > +		storage->percpu_buf =3D __alloc_percpu_gfp(size, 8, flags);
> > +		if (!storage->percpu_buf)
> > +			goto enomem;
> > 	}
> >=20
> > 	storage->map =3D (struct bpf_cgroup_storage_map *)map;
> >=20
> > 	return storage;
> > +
> > +enomem:
> > +	bpf_map_uncharge_memlock(map, pages);
> > +	kfree(storage);
> > +	return ERR_PTR(-ENOMEM);
> > +}
> > +
> > +static void free_cgroup_storage_rcu(struct rcu_head *rcu)
>=20
> Maybe rename as free_shared_cgroup_storage_rcu()?

Yeah, might be more clear.

Thank you for the review!
Will send v3 with these changes and your acks soon.

Thanks!
