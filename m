Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5819C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A22087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jUq06xNH";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="h6Rd/0Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769A22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbeLMTXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:23:50 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56038 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727608AbeLMTXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:23:49 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBDJLhYO029921;
        Thu, 13 Dec 2018 11:23:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=g8KPKDM3/do03cQRDeBGhjbZntSiBclzFpF81/1vOoE=;
 b=jUq06xNHW0U63Eb42aCEg1sEX/dxtuXiPUhqLsM6061CTbhQr94rsqlV4lS2WBDF3HZE
 /P3HRih0cAgT/Rke3zFFx5JpHyBQj3GZ1PXi5Eivq/BxEdAQuX71k4KS+JhMxn37jbvR
 AgbavYkOsxMLGojw8sLGpcozQlE7SdRfaWo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2pbrukgxd1-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Dec 2018 11:23:22 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 13 Dec 2018 11:22:55 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 13 Dec 2018 11:22:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8KPKDM3/do03cQRDeBGhjbZntSiBclzFpF81/1vOoE=;
 b=h6Rd/0OdvDGbh4lef0jPU4Wik+LUxy872zlOYIdphCOOTflSHaTD7s4jZ6/W2FP/FR98dpQVecqQQsaKpuzBxx9oWLvLb1ZpLFy/1NAlY0o/G0cw9m9XEdjudYM4vuvjOsCJRk5duxeyf+tejRKO3DggF9UNoDA+aA6RPt0b0dE=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1373.namprd15.prod.outlook.com (10.173.233.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 19:22:51 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::14db:7315:30f7:10d7]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::14db:7315:30f7:10d7%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 19:22:51 +0000
From:   Martin Lau <kafai@fb.com>
To:     Matt Mullins <mmullins@fb.com>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jessica Yu <jeyu@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: support raw tracepoints in modules
Thread-Topic: [PATCH bpf-next v2] bpf: support raw tracepoints in modules
Thread-Index: AQHUknzQUAdyL61eYUK1z7n4N6HWmKV9DX0A
Date:   Thu, 13 Dec 2018 19:22:50 +0000
Message-ID: <20181213192248.ljc6i5unafdlgryf@kafai-mbp>
References: <20181213004237.3888568-1-mmullins@fb.com>
In-Reply-To: <20181213004237.3888568-1-mmullins@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0046.namprd22.prod.outlook.com
 (2603:10b6:301:16::20) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:444e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1373;20:Gp7Oth9TtfNvPgSq86cOe5WzF9byCtbYz2Zdhcs9ZH+xkDt36e4i1az4RA+owIY9qQgpcEdCZP+BKsvl9PMb08RVk0BcE3Mn0AS383VkFtfiwJJ5rZlyEN0EzEaOIhi4CvvzlpkCFWt1wNjKHsFr8y/kzMroH9zkSsLVR9Pnwo8=
x-ms-office365-filtering-correlation-id: bba1437b-15ff-4ac4-2b99-08d661305f37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1373;
x-ms-traffictypediagnostic: MWHPR15MB1373:
x-microsoft-antispam-prvs: <MWHPR15MB1373A0608437B246A02A94CFD5A00@MWHPR15MB1373.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1373;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1373;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(9686003)(68736007)(81166006)(6246003)(316002)(7736002)(105586002)(106356001)(5660300001)(53936002)(8936002)(8676002)(6486002)(81156014)(6436002)(229853002)(305945005)(4326008)(6862004)(97736004)(11346002)(71200400001)(486006)(71190400001)(476003)(446003)(86362001)(478600001)(6636002)(99286004)(1076002)(6116002)(6506007)(6512007)(25786009)(46003)(14454004)(33896004)(14444005)(5024004)(186003)(256004)(54906003)(76176011)(52116002)(2906002)(102836004)(33716001)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1373;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5LWDb3l6Mecaa4KV9OGV94Bypf8XD32Q3dm+3n87gaaNDiUepsafKiZGm4aFTplnRkKqQqpQcybLXE/kkYld15ZVBetd53dKOcZIKEhNYb8bvRRjnJ4E3AkHcHysLiGXFMizkzlYzdxY7dkbKHniPq/htRA9j4khiAwcwEi1TXXtLLWSIJAETEvE63bX/VdzKeeq+jUY/oCwCrYGbxOEdX6tGBZ6iNa6GEqZsQE/gjVcNxF5XQ4Uq+FVkIyvmZggwi4EHlruN5c9XFOAFEVybpTwzmcVZ3CbKzEbs3jLEjRQFlE6zIVz/vlIC8+a9tpp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49F6FCE59E48214F85F4BDD59F7DF716@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bba1437b-15ff-4ac4-2b99-08d661305f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 19:22:51.2747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1373
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:42:37PM -0800, Matt Mullins wrote:
> Distributions build drivers as modules, including network and filesystem
> drivers which export numerous tracepoints.  This enables
> bpf(BPF_RAW_TRACEPOINT_OPEN) to attach to those tracepoints.
>=20
> Signed-off-by: Matt Mullins <mmullins@fb.com>
> ---
> v1->v2:
>   * avoid taking the mutex in bpf_event_notify when op is neither COMING =
nor
>     GOING.
>   * check that kzalloc actually succeeded
>=20
> I didn't try to check list_empty before taking the mutex since I want to =
avoid
> races between bpf_event_notify and bpf_get_raw_tracepoint.  Additionally,
> list_for_each_entry_safe is not strictly necessary upon MODULE_STATE_GOIN=
G, but
> Alexei suggested I use it to protect against fragility if the subsequent =
break;
> eventually disappears.
>=20
>  include/linux/module.h       |  4 ++
>  include/linux/trace_events.h |  8 ++-
>  kernel/bpf/syscall.c         | 11 ++--
>  kernel/module.c              |  5 ++
>  kernel/trace/bpf_trace.c     | 99 +++++++++++++++++++++++++++++++++++-
>  5 files changed, 120 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/module.h b/include/linux/module.h
> index fce6b4335e36..5f147dd5e709 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -432,6 +432,10 @@ struct module {
>  	unsigned int num_tracepoints;
>  	tracepoint_ptr_t *tracepoints_ptrs;
>  #endif
> +#ifdef CONFIG_BPF_EVENTS
> +	unsigned int num_bpf_raw_events;
> +	struct bpf_raw_event_map *bpf_raw_events;
> +#endif
>  #ifdef HAVE_JUMP_LABEL
>  	struct jump_entry *jump_entries;
>  	unsigned int num_jump_entries;
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 4130a5497d40..8a62731673f7 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -471,7 +471,8 @@ void perf_event_detach_bpf_prog(struct perf_event *ev=
ent);
>  int perf_event_query_prog_array(struct perf_event *event, void __user *i=
nfo);
>  int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *p=
rog);
>  int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog =
*prog);
> -struct bpf_raw_event_map *bpf_find_raw_tracepoint(const char *name);
> +struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
> +void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
>  int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id=
,
>  			    u32 *fd_type, const char **buf,
>  			    u64 *probe_offset, u64 *probe_addr);
> @@ -502,10 +503,13 @@ static inline int bpf_probe_unregister(struct bpf_r=
aw_event_map *btp, struct bpf
>  {
>  	return -EOPNOTSUPP;
>  }
> -static inline struct bpf_raw_event_map *bpf_find_raw_tracepoint(const ch=
ar *name)
> +static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const cha=
r *name)
>  {
>  	return NULL;
>  }
> +static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
> +{
> +}
>  static inline int bpf_get_perf_event_info(const struct perf_event *event=
,
>  					  u32 *prog_id, u32 *fd_type,
>  					  const char **buf, u64 *probe_offset,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 70fb11106fc2..754370e3155e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1609,6 +1609,7 @@ static int bpf_raw_tracepoint_release(struct inode =
*inode, struct file *filp)
>  		bpf_probe_unregister(raw_tp->btp, raw_tp->prog);
>  		bpf_prog_put(raw_tp->prog);
>  	}
> +	bpf_put_raw_tracepoint(raw_tp->btp);
>  	kfree(raw_tp);
>  	return 0;
>  }
> @@ -1634,13 +1635,15 @@ static int bpf_raw_tracepoint_open(const union bp=
f_attr *attr)
>  		return -EFAULT;
>  	tp_name[sizeof(tp_name) - 1] =3D 0;
> =20
> -	btp =3D bpf_find_raw_tracepoint(tp_name);
> +	btp =3D bpf_get_raw_tracepoint(tp_name);
>  	if (!btp)
>  		return -ENOENT;
> =20
>  	raw_tp =3D kzalloc(sizeof(*raw_tp), GFP_USER);
> -	if (!raw_tp)
> -		return -ENOMEM;
> +	if (!raw_tp) {
> +		err =3D -ENOMEM;
> +		goto out_put_btp;
> +	}
>  	raw_tp->btp =3D btp;
> =20
>  	prog =3D bpf_prog_get_type(attr->raw_tracepoint.prog_fd,
> @@ -1668,6 +1671,8 @@ static int bpf_raw_tracepoint_open(const union bpf_=
attr *attr)
>  	bpf_prog_put(prog);
>  out_free_tp:
>  	kfree(raw_tp);
> +out_put_btp:
> +	bpf_put_raw_tracepoint(btp);
>  	return err;
>  }
> =20
> diff --git a/kernel/module.c b/kernel/module.c
> index 49a405891587..06ec68f08387 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3093,6 +3093,11 @@ static int find_module_sections(struct module *mod=
, struct load_info *info)
>  					     sizeof(*mod->tracepoints_ptrs),
>  					     &mod->num_tracepoints);
>  #endif
> +#ifdef CONFIG_BPF_EVENTS
> +	mod->bpf_raw_events =3D section_objs(info, "__bpf_raw_tp_map",
> +					   sizeof(*mod->bpf_raw_events),
> +					   &mod->num_bpf_raw_events);
> +#endif
>  #ifdef HAVE_JUMP_LABEL
>  	mod->jump_entries =3D section_objs(info, "__jump_table",
>  					sizeof(*mod->jump_entries),
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9864a35c8bb5..9ddb6fddb4e0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -17,6 +17,43 @@
>  #include "trace_probe.h"
>  #include "trace.h"
> =20
> +#ifdef CONFIG_MODULES
> +struct bpf_trace_module {
> +	struct module *module;
> +	struct list_head list;
> +};
> +
> +static LIST_HEAD(bpf_trace_modules);
> +static DEFINE_MUTEX(bpf_module_mutex);
> +
> +static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const cha=
r *name)
> +{
> +	struct bpf_raw_event_map *btp, *ret =3D NULL;
> +	struct bpf_trace_module *btm;
> +	unsigned int i;
> +
> +	mutex_lock(&bpf_module_mutex);
> +	list_for_each_entry(btm, &bpf_trace_modules, list) {
> +		for (i =3D 0; i < btm->module->num_bpf_raw_events; ++i) {
> +			btp =3D &btm->module->bpf_raw_events[i];
> +			if (!strcmp(btp->tp->name, name)) {
> +				if (try_module_get(btm->module))
> +					ret =3D btp;
> +				goto out;
> +			}
> +		}
> +	}
> +out:
> +	mutex_unlock(&bpf_module_mutex);
> +	return ret;
> +}
> +#else
> +static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const cha=
r *name)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_MODULES */
> +
>  u64 bpf_get_stackid(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
>  u64 bpf_get_stack(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> =20
> @@ -1076,7 +1113,7 @@ int perf_event_query_prog_array(struct perf_event *=
event, void __user *info)
>  extern struct bpf_raw_event_map __start__bpf_raw_tp[];
>  extern struct bpf_raw_event_map __stop__bpf_raw_tp[];
> =20
> -struct bpf_raw_event_map *bpf_find_raw_tracepoint(const char *name)
> +struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
>  {
>  	struct bpf_raw_event_map *btp =3D __start__bpf_raw_tp;
> =20
> @@ -1084,7 +1121,16 @@ struct bpf_raw_event_map *bpf_find_raw_tracepoint(=
const char *name)
>  		if (!strcmp(btp->tp->name, name))
>  			return btp;
>  	}
> -	return NULL;
> +
> +	return bpf_get_raw_tracepoint_module(name);
> +}
> +
> +void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
> +{
> +	struct module *mod =3D __module_address((unsigned long)btp);
> +
> +	if (mod)
> +		module_put(mod);
>  }
> =20
>  static __always_inline
> @@ -1222,3 +1268,52 @@ int bpf_get_perf_event_info(const struct perf_even=
t *event, u32 *prog_id,
> =20
>  	return err;
>  }
> +
> +#ifdef CONFIG_MODULES
> +int bpf_event_notify(struct notifier_block *nb, unsigned long op, void *=
module)
> +{
> +	struct bpf_trace_module *btm, *tmp;
> +	struct module *mod =3D module;
> +
> +	if (mod->num_bpf_raw_events =3D=3D 0 ||
> +	    (op !=3D MODULE_STATE_COMING && op !=3D MODULE_STATE_GOING))
> +		return 0;
> +
> +	mutex_lock(&bpf_module_mutex);
> +
> +	switch (op) {
> +	case MODULE_STATE_COMING:
> +		btm =3D kzalloc(sizeof(*btm), GFP_KERNEL);
> +		if (btm) {
> +			btm->module =3D module;
> +			list_add(&btm->list, &bpf_trace_modules);
> +		}
Is it fine to return 0 on !btm case?

Other looks good.

> +		break;
> +	case MODULE_STATE_GOING:
> +		list_for_each_entry_safe(btm, tmp, &bpf_trace_modules, list) {
> +			if (btm->module =3D=3D module) {
> +				list_del(&btm->list);
> +				kfree(btm);
> +				break;
> +			}
> +		}
> +		break;
> +	}
> +
> +	mutex_unlock(&bpf_module_mutex);
> +
> +	return 0;
> +}
> +
> +static struct notifier_block bpf_module_nb =3D {
> +	.notifier_call =3D bpf_event_notify,
> +};
> +
> +int __init bpf_event_init(void)
> +{
> +	register_module_notifier(&bpf_module_nb);
> +	return 0;
> +}
> +
> +fs_initcall(bpf_event_init);
> +#endif /* CONFIG_MODULES */
> --=20
> 2.17.1
>=20
