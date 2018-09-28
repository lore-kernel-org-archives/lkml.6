Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894BFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371412172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pFkYVm5x";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="VguUIbtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371412172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbeI1Nqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:46:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728811AbeI1Nqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:46:30 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8S7MnXf021780;
        Fri, 28 Sep 2018 00:23:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=To9sP7/Fen+nV6So3FFdfw995RArfqZOyYtZ5w+zGCY=;
 b=pFkYVm5xw6BWMD3YYT2VmrxtWO9gWKuSMQSMPevup+O5Oh7d/KCoMWhvO5hj7EZf79Es
 EIs/sehpfeAMBwy8ameGCwK/p5nGep8ACeH27Oo6WV0eKeHwNWw3pmTz7ergFN2IZCbu
 58VZlAbiJ+t8aP/lXxL9YhnxHaSDmGv+MLs= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msejr0635-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 00:23:24 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.18) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 00:23:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To9sP7/Fen+nV6So3FFdfw995RArfqZOyYtZ5w+zGCY=;
 b=VguUIbtxq5U5WiXv2/A+W1rHV1MTh9em56+NgWUG3FbMVEXWOYDTpseg48/GiGvzBLf0HL1tmUsanruweuRA+Onk1Bbh9L+Ghh2Rvy3/wmwHxVf8EDY8/mpzhgDZB5gS42Usiu1foLkh5L+qhW4U+QkJv1uv32rv1cbw1NjiJtg=
Received: from DM5PR15MB1163.namprd15.prod.outlook.com (10.173.208.149) by
 DM5PR15MB1948.namprd15.prod.outlook.com (10.173.215.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 28 Sep 2018 07:23:21 +0000
Received: from DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::b0be:c9ca:f947:6313]) by DM5PR15MB1163.namprd15.prod.outlook.com
 ([fe80::b0be:c9ca:f947:6313%3]) with mapi id 15.20.1143.022; Fri, 28 Sep 2018
 07:23:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Thread-Topic: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Thread-Index: AQHUVEtirE9ytyh59kqeAFSxKzDreqUFT6wA
Date:   Fri, 28 Sep 2018 07:23:20 +0000
Message-ID: <9489EF78-07EA-41AC-8A4D-F3FD3359C826@fb.com>
References: <20180924211236.4149482-1-songliubraving@fb.com>
In-Reply-To: <20180924211236.4149482-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:180::1:be70]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1948;20:rlS3xUE9mM8bBsldbyGlpgPA4GpUo/X7xIMsvaPakUttS49fz6+QhkWygOyDzGYjGMz+bHdg/5mvw0Ietn7O18MODXsDHZ3AhrkijGTzW1qb3Y1eTAArdPBELiu6oHvHly3QquMl3veesRb40wRQb6ldS3jetlIyaV9V9VHRTto=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1592c473-b9a8-4980-29c5-08d6251344f3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1948;
x-ms-traffictypediagnostic: DM5PR15MB1948:
x-microsoft-antispam-prvs: <DM5PR15MB1948D02BB136505B28B52B32B3EC0@DM5PR15MB1948.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(93006095)(93001095)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DM5PR15MB1948;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1948;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(136003)(396003)(189003)(199004)(8676002)(8936002)(68736007)(4326008)(82746002)(256004)(6246003)(34290500001)(81156014)(81166006)(50226002)(2616005)(7736002)(11346002)(476003)(446003)(486006)(186003)(6486002)(229853002)(83716004)(14454004)(102836004)(6436002)(25786009)(53936002)(478600001)(6512007)(53546011)(97736004)(6506007)(86362001)(5660300001)(36756003)(71190400001)(6116002)(106356001)(305945005)(76176011)(99286004)(316002)(110136005)(57306001)(46003)(2906002)(33656002)(2900100001)(105586002)(5250100002)(54906003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1948;H:DM5PR15MB1163.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vJBFzDQMggNOfo9PSF3f45Svj/iR/c3aXv/a49WOBaqIJkVv6kJxqLghtMOlPpUrj+7vIy6Yh3x3OSPjESW9HMfaUDfHF6H9Z5+ZmS6SQiclOs8V5RuzeWTeM2sJXp9FFr4K5peNy5DrMOVEZK0P254dFZx6UXV0Vk1Np2j37HjQJAoFVw6KoeunMlsU8scqQE3jbwmCyzX2qQXzqqjplqlwlPoI5KNGfuN3WdszJuvxd9n+GmbbnqxH5Dr6kvzWi6zRbGgpQhXd5ti5etd4a/DLXO2uC4UNGFIySmIRskHLQVWYT2ITsvg3F+xZ7gVvtv3CFq1xaeI6aGKg3hNftf2IUCiwEy6v7Kt/hmGAODk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28DF048C9675BC459358CDDAEC843D60@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1592c473-b9a8-4980-29c5-08d6251344f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 07:23:20.8084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1948
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,


> On Sep 24, 2018, at 2:12 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> This patch enables uprobes with reference counter in fd-based uprobe.
> Highest 40 bits of perf_event_attr.config is used to stored offset
> of the reference counter (semaphore).
>=20
> Format information in /sys/bus/event_source/devices/uprobe/format/ is
> updated to reflect this new feature.
>=20
> Signed-off-by: Song Liu <songliubraving@fb.com>
> Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> include/linux/trace_events.h    |  3 +-
> kernel/events/core.c            | 49 ++++++++++++++++++++++++++-------
> kernel/trace/trace_event_perf.c |  7 +++--
> kernel/trace/trace_probe.h      |  3 +-
> kernel/trace/trace_uprobe.c     |  4 ++-
> 5 files changed, 50 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 78a010e19ed4..4130a5497d40 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -575,7 +575,8 @@ extern int bpf_get_kprobe_info(const struct perf_even=
t *event,
> 			       bool perf_type_tracepoint);
> #endif
> #ifdef CONFIG_UPROBE_EVENTS
> -extern int  perf_uprobe_init(struct perf_event *event, bool is_retprobe)=
;
> +extern int  perf_uprobe_init(struct perf_event *event,
> +			     unsigned long ref_ctr_offset, bool is_retprobe);
> extern void perf_uprobe_destroy(struct perf_event *event);
> extern int bpf_get_uprobe_info(const struct perf_event *event,
> 			       u32 *fd_type, const char **filename,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c80549bf82c6..a4ad5235ec9b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8368,30 +8368,39 @@ static struct pmu perf_tracepoint =3D {
>  *
>  * PERF_PROBE_CONFIG_IS_RETPROBE if set, create kretprobe/uretprobe
>  *                               if not set, create kprobe/uprobe
> + *
> + * The following values specify a reference counter (or semaphore in the
> + * terminology of tools like dtrace, systemtap, etc.) Userspace Statical=
ly
> + * Defined Tracepoints (USDT). Currently, we use 40 bit for the offset.
> + *
> + * PERF_UPROBE_REF_CTR_OFFSET_BITS	# of bits in config as th offset
> + * PERF_UPROBE_REF_CTR_OFFSET_SHIFT	# of bits to shift left
>  */
> enum perf_probe_config {
> 	PERF_PROBE_CONFIG_IS_RETPROBE =3D 1U << 0,  /* [k,u]retprobe */
> +	PERF_UPROBE_REF_CTR_OFFSET_BITS =3D 40,
> +	PERF_UPROBE_REF_CTR_OFFSET_SHIFT =3D 64 - PERF_UPROBE_REF_CTR_OFFSET_BI=
TS,
> };
>=20
> PMU_FORMAT_ATTR(retprobe, "config:0");
> +#endif
>=20
> -static struct attribute *probe_attrs[] =3D {
> +#ifdef CONFIG_KPROBE_EVENTS
> +static struct attribute *kprobe_attrs[] =3D {
> 	&format_attr_retprobe.attr,
> 	NULL,
> };
>=20
> -static struct attribute_group probe_format_group =3D {
> +static struct attribute_group kprobe_format_group =3D {
> 	.name =3D "format",
> -	.attrs =3D probe_attrs,
> +	.attrs =3D kprobe_attrs,
> };
>=20
> -static const struct attribute_group *probe_attr_groups[] =3D {
> -	&probe_format_group,
> +static const struct attribute_group *kprobe_attr_groups[] =3D {
> +	&kprobe_format_group,
> 	NULL,
> };
> -#endif
>=20
> -#ifdef CONFIG_KPROBE_EVENTS
> static int perf_kprobe_event_init(struct perf_event *event);
> static struct pmu perf_kprobe =3D {
> 	.task_ctx_nr	=3D perf_sw_context,
> @@ -8401,7 +8410,7 @@ static struct pmu perf_kprobe =3D {
> 	.start		=3D perf_swevent_start,
> 	.stop		=3D perf_swevent_stop,
> 	.read		=3D perf_swevent_read,
> -	.attr_groups	=3D probe_attr_groups,
> +	.attr_groups	=3D kprobe_attr_groups,
> };
>=20
> static int perf_kprobe_event_init(struct perf_event *event)
> @@ -8433,6 +8442,24 @@ static int perf_kprobe_event_init(struct perf_even=
t *event)
> #endif /* CONFIG_KPROBE_EVENTS */
>=20
> #ifdef CONFIG_UPROBE_EVENTS
> +PMU_FORMAT_ATTR(ref_ctr_offset, "config:63-24");

I guess you meant this part? This is for uprobe only, so I put
it here.=20

Thanks,
Song

> +
> +static struct attribute *uprobe_attrs[] =3D {
> +	&format_attr_retprobe.attr,
> +	&format_attr_ref_ctr_offset.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group uprobe_format_group =3D {
> +	.name =3D "format",
> +	.attrs =3D uprobe_attrs,
> +};
> +
> +static const struct attribute_group *uprobe_attr_groups[] =3D {
> +	&uprobe_format_group,
> +	NULL,
> +};
> +
> static int perf_uprobe_event_init(struct perf_event *event);
> static struct pmu perf_uprobe =3D {
> 	.task_ctx_nr	=3D perf_sw_context,
> @@ -8442,12 +8469,13 @@ static struct pmu perf_uprobe =3D {
> 	.start		=3D perf_swevent_start,
> 	.stop		=3D perf_swevent_stop,
> 	.read		=3D perf_swevent_read,
> -	.attr_groups	=3D probe_attr_groups,
> +	.attr_groups	=3D uprobe_attr_groups,
> };
>=20

