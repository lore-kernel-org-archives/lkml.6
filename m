Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3272217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fpn6oSMd";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iME5jE6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfBRS6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:58:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728023AbfBRS6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:58:32 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IIvjiv009289;
        Mon, 18 Feb 2019 10:57:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tALuHWBatwglxy3yoUHlBUDPau8p7GN6WT364Z04GQk=;
 b=fpn6oSMdPiW4PxhMOpfiD4IxTnZnWBHZDITMn9+19oedz6lTd+D8CyNCCcc6RLTNwyGm
 TFzYwlYQdVSBwFDNs8dwEAjelNMiQSOh6BMpDBDjKw4y2f5UPIcnJ7hQcsDoM7p431VR
 GmWo5LdjeL5YE1wsvXlbhKJCXJAs7bZi2p0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qqy20gnfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Feb 2019 10:57:49 -0800
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 18 Feb 2019 10:57:48 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 18 Feb 2019 10:57:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tALuHWBatwglxy3yoUHlBUDPau8p7GN6WT364Z04GQk=;
 b=iME5jE6Dn0prgZrjjePV+fCytYousb88C+B2/E+ty/CUoSFbvV9i7FKE3lLPMXFSHUvHZgx5ugMd+98hCVW8YRMnLunN7HzXjkA65W5Oi5GVAvDJ6/+g1yC9HyktFD1wW0YJReLv4OGJP56jNX2U7uKi9BbX4vUbN7cMmDkMiws=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3509.namprd15.prod.outlook.com (20.179.60.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 18:57:45 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ecc7:1a8c:289f:df92%3]) with mapi id 15.20.1601.016; Mon, 18 Feb 2019
 18:57:45 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@surriel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Wolfgang Walter <linux@stwm.de>, Spock <dairinin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a
 relatively small number of objects"
Thread-Topic: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a
 relatively small number of objects"
Thread-Index: AQHUx5DFfbn2t2YpWUeoO4VrMVhutaXlrrEAgAAMzwCAABbegIAAFiaA
Date:   Mon, 18 Feb 2019 18:57:45 +0000
Message-ID: <20190218185738.GA3745@castle.DHCP.thefacebook.com>
References: <20190218133454.668268457@linuxfoundation.org>
 <20190218133501.533140116@linuxfoundation.org>
 <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com>
 <20190218161634.GA30873@kroah.com> <20190218173825.GB4525@dhcp22.suse.cz>
In-Reply-To: <20190218173825.GB4525@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0050.namprd02.prod.outlook.com
 (2603:10b6:301:73::27) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:17d5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d33c108-463c-434b-6b36-08d695d2f7c8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3509;
x-ms-traffictypediagnostic: BYAPR15MB3509:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3509;20:gSTJ2UQyz61jx+g5wn5SgFaM1mAM24CsYcQ8C0L3kd2HwvTc5tCtKaSmNPhLKNs8JocQkU9th26l4rz4ZgA46Ca1znsZ2kbObm6Qkxfa+vlT0+eIjV6nhoc7Rhl+k3WVbE3vUT9P3bZnAG4EtpQ40Qo+52fU+/nkxZ+KAFp5LXM=
x-microsoft-antispam-prvs: <BYAPR15MB3509FD64E3CA226EFB4FCC73BE630@BYAPR15MB3509.namprd15.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(6486002)(71200400001)(7416002)(71190400001)(6916009)(93886005)(229853002)(4326008)(256004)(33656002)(14444005)(561944003)(6116002)(76176011)(106356001)(486006)(11346002)(25786009)(99286004)(446003)(476003)(8676002)(53936002)(97736004)(2906002)(54906003)(9686003)(386003)(6512007)(5660300002)(81156014)(316002)(46003)(14454004)(81166006)(8936002)(68736007)(1076003)(6436002)(186003)(33896004)(7736002)(52116002)(305945005)(86362001)(6246003)(105586002)(102836004)(478600001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3509;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 52fJeHqQ2DijjadVR3gTH+qD4jMq4ub/cZaR2INqm1zCxDMzo0VzUpragVbXSbUUnknjx+H21nj/MC/KMcyUNbTPZ3tO2jJ0wOVXWCV+UNPoRgner9ubL8AIB/6ZJ+CjYVKYb3npuc3gfKwG5aRNHZYpQwQgdd+tV9QvPBec/B5ivRXhnpPkd6vpo8QR9INLrVAI7Py0Lf7q/VgWKBng9bHk4nsrsBPalJpOoFM6wBU+5xufxRfw+V8x9KFxLZBx0jKtQJ0Op+h9mh1zG1nuq0f72CauEuJNrysEOkJEDRyyE3fxdLj12Z9N1/zZNcFvokNWLYoJVwz7/gKrMgW2SSQFZQLW/DHr74Kb61wpLHKl3I4AEFdkE1Oe7JLI4IKeHShj1sU/ABWO0g5jU9daXj1Cky3ZN9X1rD2cKUeSxyg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D17D0574BFA2F44A1BA2B0DBFFE7361@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d33c108-463c-434b-6b36-08d695d2f7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 18:57:44.4286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3509
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 06:38:25PM +0100, Michal Hocko wrote:
> On Mon 18-02-19 17:16:34, Greg KH wrote:
> > On Mon, Feb 18, 2019 at 10:30:44AM -0500, Rik van Riel wrote:
> > > On Mon, 2019-02-18 at 14:43 +0100, Greg Kroah-Hartman wrote:
> > > > 4.20-stable review patch.  If anyone has any objections, please let
> > > > me know.
> > > >=20
> > > > ------------------
> > > >=20
> > > > From: Dave Chinner <dchinner@redhat.com>
> > > >=20
> > > > commit a9a238e83fbb0df31c3b9b67003f8f9d1d1b6c96 upstream.
> > > >=20
> > > > This reverts commit 172b06c32b9497 ("mm: slowly shrink slabs with a
> > > > relatively small number of objects").
> > >=20
> > > This revert will result in the slab caches of dead
> > > cgroups with a small number of remaining objects never
> > > getting reclaimed, which can be a memory leak in some
> > > configurations.
> > >=20
> > > But hey, that's your tradeoff to make.
> >=20
> > That's what is in Linus's tree.  Should we somehow diverge from that?
>=20
> I believe we should start working on a memcg specific solution to
> minimize regressions for others and start a more complex solution from
> there.
>=20
> Can we special case dead memcgs in the slab reclaim and reclaim more
> aggressively?

It's probably better to start a new thread to discuss this issue (btw,
doesn't LSF/MM looks like the best place to do it? I can send a proposal).

But I don't think dead cgroups are any special here. At the moment when
a cgroup is deleted, associated slab objects can be perfectly used by proce=
sses
in other cgroups, so we can't reclaim them. Slab objects (vfs objects first
of all) are quite often shared between cgroups, we can't just ignore it.

So in order to avoid leaks we'll need to apply some artificial pressure
constantly, and then it's not clear why we need to do it separately
for dead and living cgroups.

So I still believe that Rik's/mine approach is the right thing to do,
we just need to apply the pressure gently, including all corner cases
(e.g. concurrency issues spotted by Dave).

Generally speaking, the problem occurs because the lifecycle of a
slab object can be much longer than the lifecycle of the corresponding memo=
ry
cgroup. And because we pin the memcg by the object, we're wasting lot of
memory. Right now we allow certain amount of vfs objects to reside in the
memory pretty much forever unless we have a really strong memory pressure.
It's arguable fine because inodes and dentries are relatively small, but
if each of them holds a 200kb+ dead memcg, it becomes very noticeable.

So we either have to apply the memory pressure more evenly (what Rik and I
are proposing), or completely reparent slab objects on cgroup removal.

Thanks!
