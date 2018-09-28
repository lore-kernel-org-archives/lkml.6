Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F72C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE90E20666
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Adl5daNS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="i5yexqCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE90E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeI1VPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 17:15:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48854 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbeI1VPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 17:15:04 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SEmvXi023242;
        Fri, 28 Sep 2018 07:50:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NoZJzgfH/Sc9Ovp+fE3Thv08f5qqYNXEYRrc+v8YJdw=;
 b=Adl5daNSVdjGda4pd4nOggGbSY0tpa6l999UGPAF339C3Wo3FbdDPXvDesGN212YBxfJ
 4r4S4zwNycO3MbspEKeIxUXvT93r5Q85wSKN5+n++aX/7bgXdZzwRVj4pJWkOZWkeX74
 toFrzwQmlqgro8RYeh7Ci08bAVSrZbZVhak= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2msk4qgm10-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 07:50:30 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 28 Sep 2018 10:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoZJzgfH/Sc9Ovp+fE3Thv08f5qqYNXEYRrc+v8YJdw=;
 b=i5yexqCmsAY1HLAZPrPAaF54EpvfcoyqTFbrGxwiEOBtpxH0nMyu9nbRjPzT2W6snoZuIMhc8Jd4wsg6j8eNhAYRGUv08KrfaByXIMoZPNCQ+2JctV5CdJHhUUaq2kkrz+MdDx/E9AuL9/cxDxY0xJgVsoOvIESMv8GHYSeB7bg=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1632.namprd15.prod.outlook.com (10.175.135.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 28 Sep 2018 14:50:23 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f809:2e0d:6e1c:924a%7]) with mapi id 15.20.1185.022; Fri, 28 Sep 2018
 14:50:23 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Thread-Topic: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Thread-Index: AQHUVEtirE9ytyh59kqeAFSxKzDreqUFT6wAgAAIGYCAAHTOAA==
Date:   Fri, 28 Sep 2018 14:50:23 +0000
Message-ID: <C9D064BF-BFB0-409E-B470-1128B570A92D@fb.com>
References: <20180924211236.4149482-1-songliubraving@fb.com>
 <9489EF78-07EA-41AC-8A4D-F3FD3359C826@fb.com>
 <20180928075219.GH3439@hirez.programming.kicks-ass.net>
In-Reply-To: <20180928075219.GH3439@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:180::1:5dbf]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1632;20:Vp4Sf5O073WI4KZ2MPLxejdk+CTMG7S+Oav3AXeZstCTjeRxrhFEQeCTi6tiCDR0/NAxZE8/GYQfILzBuzt8nBir2kayHtEt3HByVYua8PAyUzcldTkmVfKYUfvTyctNTqZ8x9gOETdlhhaDEj+7mEribv7a018RTaqMgcGOf0s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f4d22a37-f024-4abf-d83a-08d62551b84b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1632;
x-ms-traffictypediagnostic: MWHPR15MB1632:
x-microsoft-antispam-prvs: <MWHPR15MB1632C6D0E16D63EC99EF64E3B3EC0@MWHPR15MB1632.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302061)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:MWHPR15MB1632;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1632;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(76176011)(86362001)(97736004)(36756003)(99286004)(57306001)(106356001)(71190400001)(83716004)(14454004)(14444005)(4326008)(6506007)(256004)(81156014)(81166006)(5250100002)(6116002)(316002)(53546011)(2906002)(33656002)(8936002)(2616005)(476003)(71200400001)(486006)(8676002)(11346002)(82746002)(478600001)(46003)(446003)(25786009)(68736007)(54906003)(102836004)(6436002)(6246003)(229853002)(105586002)(50226002)(53936002)(34290500001)(6916009)(186003)(305945005)(2900100001)(7736002)(5660300001)(6486002)(6512007)(87944003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1632;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IY5XheiOHXPmtvHq7QIlPe9l3f1Nbg08Kv9TRjm79yL0g1bvnX8rI+gBEe79pexcqP1/Gu/ZfqAn6FrtK4ngeAGWfhfds3INcPM2ZbLfnJNyj1u/S+qpEIe11W7IP2lvWlIlskEWu81JmB+q+TKAjOuLI7aFODLshIjFQkN1ECMv+UumCQ2eTO7/9c8PWHYRS3/gVVUIwiD2TiMG5G608x3O9M3A88PXSmlX1tXfP/9FpdbY8epyHrY1Tgvc182kTMQJBMPm9GxSWE1ofHNqOSBr6f7nRkDRK8+28quOZJL3eLQM38NzzAlXD9WWXjNIvYeSg2v6e/vP9j5wpew6RWFXL5Y+TZHg+QXU+fqT0Jw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E138AF135CB1947B90C278E3639D0EA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d22a37-f024-4abf-d83a-08d62551b84b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 14:50:23.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1632
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 28, 2018, at 12:52 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Fri, Sep 28, 2018 at 07:23:20AM +0000, Song Liu wrote:
>> Hi Peter,
>>> #ifdef CONFIG_UPROBE_EVENTS
>>> +PMU_FORMAT_ATTR(ref_ctr_offset, "config:63-24");
>>=20
>> I guess you meant this part? This is for uprobe only, so I put
>> it here.=20
>=20
> Ah,.. right you are.
>=20
> You seem to have the bitfield backwards, does that mean we should write
> the bits in backwards too? Seems a tad loopy if you ask me.
>=20
> Did you instead mean: "config:24-63" ? Also, why 40 bits? 32 seems like
> a much more natural amount.

I guess it should be "config:24-63". I didn't realize the bit order here.=20
I picked 40 bits files up to 1 TB. 32 bits should be also be enough for=20
most cases. Let me fix these in v2.=20

Thanks,
Song

