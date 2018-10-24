Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D6ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DD62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XDUxrODF";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Oi/fKfhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DD62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeJYCwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:52:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45578 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbeJYCwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:52:49 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9OIDkSv025628;
        Wed, 24 Oct 2018 11:23:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dFNdfFeCk10GJcVuDmgeV5KcHlxn4oo1ou3+ZDwlJNI=;
 b=XDUxrODFc0r7p5DOERTMTPNTOEjgobUuSXyoWl5hntS5CCsQdVKgu99rSolkFMCprhWJ
 QsmikiBuKw1mFXt7JEZSQInl4pQMY6jIaDhlSRZiInAtFF0oUtTu6PL9mgbFZeplcwKd
 Kgd2en1J9rpZoh2h2xWaIZXMjhcdAtFB3U0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2navn9gbhr-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Oct 2018 11:23:29 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 24 Oct 2018 11:22:48 -0700
Received: from FRC-CHUB10.TheFacebook.com (2620:10d:c021:18::29) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Wed, 24 Oct 2018 11:22:48 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 24 Oct 2018 14:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFNdfFeCk10GJcVuDmgeV5KcHlxn4oo1ou3+ZDwlJNI=;
 b=Oi/fKfhDOvaVXqCLAD1MCV244RmgJf1GaT109FfZNlNrfSRy3tYXVxxyZCd3aLJnUtbRwXXdUhYR+y788DVdBnPTEl83+KrHieimpwJmFyoP3os0aRyU34c/N1NRWx8wO00y1WM8fs6uS0ODpVlfXhn0TLWW49kWcNzP6rQt4Uc=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1357.namprd15.prod.outlook.com (10.173.232.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Wed, 24 Oct 2018 18:22:46 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::c56f:45c:1647:a419]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::c56f:45c:1647:a419%3]) with mapi id 15.20.1250.028; Wed, 24 Oct 2018
 18:22:46 +0000
From:   Martin Lau <kafai@fb.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Kangjie Lu <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] bpf: btf: Fix a missing-check bug
Thread-Topic: [PATCH v2] bpf: btf: Fix a missing-check bug
Thread-Index: AQHUa5mXie9xmsybbEORoB7Wt/lhG6UuMIAAgACFY4A=
Date:   Wed, 24 Oct 2018 18:22:46 +0000
Message-ID: <20181024182239.lz7uicceihzmxabh@kafai-mbp>
References: <1540386020-30680-1-git-send-email-wang6495@umn.edu>
 <20181024172514.l33dsaqdvs5yewvm@kafai-mbp>
In-Reply-To: <20181024172514.l33dsaqdvs5yewvm@kafai-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:300:95::29) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:be1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1357;20:fiJVaFn8qTtEbMlISkts2u0ZFdV0bgAArjIx4iLv0YzYZHZ9VIu39pDsobCguq4V9Rzt8lf7nis2K3AfCe0B5mYJlkPpWYu0XBZhC/M6mgd1+ycOPhHdSIOFtOsvMBAsMZalWAlPB0O2zJlknNfpPzEemHVJVREHi3OR1WwZfxA=
x-ms-office365-filtering-correlation-id: 10208209-17ea-47b7-36fc-08d639ddb1e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1357;
x-ms-traffictypediagnostic: MWHPR15MB1357:
x-microsoft-antispam-prvs: <MWHPR15MB135751AB3F8023C52E2A2929D5F60@MWHPR15MB1357.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(67672495146484)(8104003914727);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1357;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1357;
x-forefront-prvs: 083526BF8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(6116002)(8676002)(81166006)(81156014)(5250100002)(97736004)(478600001)(1076002)(8936002)(14454004)(476003)(46003)(33716001)(186003)(11346002)(446003)(7736002)(14444005)(256004)(305945005)(486006)(86362001)(68736007)(6246003)(229853002)(2171002)(4326008)(33896004)(76176011)(386003)(6506007)(6512007)(52116002)(25786009)(53936002)(6436002)(6486002)(2906002)(5660300001)(102836004)(6916009)(71200400001)(316002)(71190400001)(105586002)(2900100001)(106356001)(9686003)(54906003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1357;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: b5JkKlBHdmxe0+1VsVNB6RUvE3JUQeAs+iTRMZfNCIw89fMAt/5c6N2pdiyKpSb8hX1HY4HcXbinW5jPmo4Ki88AYNRRAq7bQp8xlWaqsBh2fxLUdb7cLNsZf7H9sIJtRVeW0qtn13utlwUFzsM5VAQNzIl7ApeI44yGyteE4YRQDSiYs4nGcTtX0ayDDL5JEtImEyExeJX6Zqr4mzqyDoKWmf3Hz3bD7ml81zBfWEfONxzk+QTkqYCstgVPeUCwwVBrw9P9gEN3L2gZFh6yuZN/vwCQYzToUWmSFjJEXQBbAr/T7VBcF5okd7T66MD0cIRMpv3hvvYWeQAJDqAr3hfHSAMcR7vXQSbODgdolpY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <456989B783EEC440BE50DBA7A72D849F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 10208209-17ea-47b7-36fc-08d639ddb1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2018 18:22:46.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1357
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 05:26:23PM +0000, Martin Lau wrote:
> On Wed, Oct 24, 2018 at 08:00:19AM -0500, Wenwen Wang wrote:
> > In btf_parse(), the header of the user-space btf data 'btf_data' is fir=
stly
> > parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the he=
ader
> > is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and the=
n
> > verified. If no error happens during the verification process, the whol=
e
> > data of 'btf_data', including the header, is then copied to 'data' in
> > btf_parse(). It is obvious that the header is copied twice here. More
> > importantly, no check is enforced after the second copy to make sure th=
e
> > headers obtained in these two copies are same. Given that 'btf_data'
> > resides in the user space, a malicious user can race to modify the head=
er
> > between these two copies. By doing so, the user can inject inconsistent
> > data, which can cause undefined behavior of the kernel and introduce
> > potential security risk.
btw, I am working on a patch that copies the btf_data before parsing/verify=
ing
the header.  That should avoid this from happening but that will
require a bit more code churns for the bpf branch.

> >=20
> > To avoid the above issue, this patch copies the parsed header from
> > 'btf->hdr' to 'data'. The remaining part in 'data' is still copied from=
 the
> > user-space 'btf_data'.
> LGTM.
>=20
> Acked-by: Martin KaFai Lau <kafai@fb.com>
>=20
> >=20
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> > ---
> >  kernel/bpf/btf.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 378cef7..b52a834a 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -2152,6 +2152,7 @@ static struct btf *btf_parse(void __user *btf_dat=
a, u32 btf_data_size,
> >  	struct btf_verifier_env *env =3D NULL;
> >  	struct bpf_verifier_log *log;
> >  	struct btf *btf =3D NULL;
> > +	u32 hdr_len;
> >  	u8 *data;
> >  	int err;
> > =20
> > @@ -2200,7 +2201,15 @@ static struct btf *btf_parse(void __user *btf_da=
ta, u32 btf_data_size,
> >  	btf->data_size =3D btf_data_size;
> >  	btf->nohdr_data =3D btf->data + btf->hdr.hdr_len;
> > =20
> > -	if (copy_from_user(data, btf_data, btf_data_size)) {
> > +	/*
> > +	 * The header at btf_data could be modified by a malicious user
> > +	 * after it is parsed. So we copy the parsed header here. The
> > +	 * remaining part is still copied from btf_data.
> > +	 */
> > +	hdr_len =3D min_t(u32, btf->hdr.hdr_len, sizeof(btf->hdr));
> > +	memcpy(data, &btf->hdr, hdr_len);
> > +	if (copy_from_user(data + hdr_len, (u8 __user *)btf_data + hdr_len,
> > +				btf_data_size - hdr_len)) {
> >  		err =3D -EFAULT;
> >  		goto errout;
> >  	}
> > --=20
> > 2.7.4
> >=20
