Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E453BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CC620844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DdTHGXUq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZWkKCzww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CC620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbeGIQlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:41:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58026 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932755AbeGIQlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:41:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w69GePSa011806;
        Mon, 9 Jul 2018 09:40:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=e4+6ScsU+SLXxj23bNp0Nj1r5mG9KctHrraiK5U7SlU=;
 b=DdTHGXUqtS12sLpeRdWlWl+Aupb7SbeavYD+3iwTTqA/vEZbe7SsfwsMwEH8ii4miwer
 ZlX/9rum6Lv0Anig15hjdI4tlq1Via3DdWt2y9oLYE4YZBBtXwoMcDmP69VTyP9EajVu
 lLQSgIAX1KImAgS6z9LMcZAJpdey2oV0QgY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k4a80r9hd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 09 Jul 2018 09:40:27 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB12.TheFacebook.com (2620:10d:c081:35::21) with Microsoft SMTP Server
 (TLS) id 14.3.319.2; Mon, 9 Jul 2018 09:40:26 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 9 Jul 2018 09:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4+6ScsU+SLXxj23bNp0Nj1r5mG9KctHrraiK5U7SlU=;
 b=ZWkKCzwwpcVCy2sfIOVmtvWHqrbj0cufMw9UuDv6JCpJm7HhiOaeDZRpg9PLqlykVqgr80Vi3bZHfMcrWVJe0/90AwuTwpJsjd7vx7+rx48w8gY0FX09d8ieWIxWUq6WFTuBbhRmvvgqtGuiI7JYi9rzw3jh9i2vdYsSspy/STw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1405.namprd15.prod.outlook.com (10.173.234.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 16:40:23 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::c80f:cb55:d63b:2734]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::c80f:cb55:d63b:2734%11]) with mapi id 15.20.0930.016; Mon, 9 Jul 2018
 16:40:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>, Josef Bacik <jbacik@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing/kprobe: Release kprobe print_fmt properly
Thread-Topic: [PATCH] tracing/kprobe: Release kprobe print_fmt properly
Thread-Index: AQHUF4/fLkjXf/uI6kiw0rf75M6I7qSHF+2A
Date:   Mon, 9 Jul 2018 16:40:22 +0000
Message-ID: <F41993EE-6A61-4958-B887-966C2AE71DD0@fb.com>
References: <20180709141906.2390-1-jolsa@kernel.org>
In-Reply-To: <20180709141906.2390-1-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.8.2)
x-originating-ip: [2620:10d:c090:200::6:7af4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1405;7:4rr8tWLdzeJlejAE8yJiY3L6zTQVdh+UuOSv5Ll55n7ozJAH+xSb+CHVKaRY2bfYPPvNRKPN7GMw07qxKx64uumqm7jDott+huhYF2q/3jtRXy6ziKaXT9a5marrxg+dRF8EpPNfte7HD/mGrProDklLIPVT2/EjeWU7DtMmN5Du5eUblun3Wdf5y3LdbOr2vHzZAhOHSrx5TzcvyckHrkusZF8WTI9DMaKsAlT2A8yH286vq0CTby+t8quNdgEF;20:eUfockDMWRNA+odj0D8ptVXv/4U2B8GkcH7Rg956UB3WyUP6e2IeHS8pP3nxWNA3UuN5mLfToChonDgtcEZSd+kv8hmJGEGsPesR4KhzyOr96e1/ZP7UO7ek02KXbiDgcE9kXtAdCuTMSV5LA4Z1zlgXXxYfL9tI7ANrgu41thw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(189003)(199004)(51914003)(36756003)(11346002)(476003)(33656002)(50226002)(2616005)(105586002)(106356001)(68736007)(53936002)(478600001)(14454004)(256004)(14444005)(97736004)(2900100001)(486006)(6246003)(82746002)(446003)(83716003)(6506007)(76176011)(2906002)(7416002)(25786009)(46003)(316002)(99286004)(102836004)(54906003)(8936002)(7736002)(57306001)(6916009)(6512007)(229853002)(6486002)(6116002)(86362001)(81156014)(186003)(81166006)(4326008)(53546011)(305945005)(5660300001)(5250100002)(6436002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1405;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 92224087-b1a9-445a-2433-08d5e5baaa1b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1405;
x-ms-traffictypediagnostic: MWHPR15MB1405:
x-microsoft-antispam-prvs: <MWHPR15MB14059FD9BB6E77D25797C7E2B3440@MWHPR15MB1405.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1405;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1405;
x-forefront-prvs: 07283408BE
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jsSJTNo7oHh2MhqsDXIAQcVDdAkZLmaQAtmH5INBOQqSgJhjDZNNqmyEcBT1M9su2MST9eZLp2FUOzv5ZejzVNa/uuEJW5c3O0yulPoZjy6617lLuV9JvSVWtFGqYQCI/8BVvYI3+X4055AUGJIEL3TT9ZNwwb3wMWWTw8S2zHKmZGnSXi5d4+24JwmLyhQCJfowxCfnclOBc1q1hyArFOEl9dc3lG1Xf8HpL526HdeTe4ljjGz6/t9qQsletLfhceUhm4Z55/OzZ5CTpXc/NPSb4MgwtYIm4oMJXLwbogg2jytDydw11PyB6X9fmfBtHAkrNz6RyA/d+UOVC1SATbT8vaEiwx6DQ1yeIvlbOpg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A3CC4BCF5BD0542842C555140EF2414@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92224087-b1a9-445a-2433-08d5e5baaa1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 16:40:22.1394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1405
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-09_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 9, 2018, at 7:19 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> We don't release tk->tp.call.print_fmt when destroying
> local uprobe. Also there's missing print_fmt kfree in
> create_local_trace_kprobe error path.
>=20
> Fixes: e12f03d7031a ("perf/core: Implement the 'perf_kprobe' PMU")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for the fix!

Acked-by: Song Liu <songliubraving@fb.com>


> ---
> kernel/trace/trace_kprobe.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index daa81571b22a..21f718472942 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1480,8 +1480,10 @@ create_local_trace_kprobe(char *func, void *addr, =
unsigned long offs,
> 	}
>=20
> 	ret =3D __register_trace_kprobe(tk);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(tk->tp.call.print_fmt);
> 		goto error;
> +	}
>=20
> 	return &tk->tp.call;
> error:
> @@ -1501,6 +1503,8 @@ void destroy_local_trace_kprobe(struct trace_event_=
call *event_call)
> 	}
>=20
> 	__unregister_trace_kprobe(tk);
> +
> +	kfree(tk->tp.call.print_fmt);
> 	free_trace_kprobe(tk);
> }
> #endif /* CONFIG_PERF_EVENTS */
> --=20
> 2.17.1
>=20

