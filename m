Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7704ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A14214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=catalogicsoftware.com header.i=@catalogicsoftware.com header.b="hes4RDjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A14214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=catalogicsoftware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeIRGOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:14:54 -0400
Received: from us-smtp-delivery-107.mimecast.com ([63.128.21.107]:37790 "EHLO
        us-smtp-delivery-107.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbeIRGOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:14:53 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Sep 2018 02:14:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catalogicsoftware.com; s=mimecast20180821; t=1537231500; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=NbN4tw0OZl0xugJ0oQqU3OMqIKPWv9jyXhBuyH+9dtE=; b=hes4RDjtsUeSBB26Bd+QeVbG2XbKnjDU1/2hAyeH1BeFDKD8WYr5ZY6vbWNJd6LZ3Ob/7wEiVH0+dQg0ZDOyo0iznvm/eC7Qsu8UtxXlaxF3kPkC/ozJ6e6MrpEY2Nk3EA5sWRTHVdKFGB2XyNUTTkOzxxGcAkw5yeW2MmDAERI=
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03lp0016.outbound.protection.outlook.com [207.46.163.16])
 (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-294-xG7ZdLJXOjqiV231qHIAIQ-1; Mon, 17 Sep 2018 20:37:13 -0400
Received: from DM5PR01MB2348.prod.exchangelabs.com (10.168.192.138) by
 DM5PR01MB2699.prod.exchangelabs.com (10.172.185.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Tue, 18 Sep 2018 00:37:11 +0000
Received: from DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::55fd:2d5a:fdbc:51a1]) by DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::55fd:2d5a:fdbc:51a1%6]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 00:37:11 +0000
From:   "Ly, Bryant" <bly@catalogicsoftware.com>
To:     Laura Abbott <labbott@redhat.com>
CC:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/2] scsi: ibmvscsis: Fix a stringop-overflow warning
Thread-Topic: [PATCHv3 1/2] scsi: ibmvscsis: Fix a stringop-overflow warning
Thread-Index: AQHUTue8XqW/6HgMhUG27FT8Dl/7Jw==
Date:   Tue, 18 Sep 2018 00:37:11 +0000
Message-ID: <B86907DE-444B-498D-A402-78190A5A402B@catalogicsoftware.com>
References: <20180911192226.3620-1-labbott@redhat.com>
 <20180911192226.3620-2-labbott@redhat.com>
In-Reply-To: <20180911192226.3620-2-labbott@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [96.42.214.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR01MB2699;20:sVQ05ui/P6dRlGByIT2QnLuP4MwMfGFOsZ0X1AxXqCT4V4qGua7Dd2EPIn5OCGhNJAyRtfRao42b3eLtYZKcw/GJC7JAR7Cl8OmxphXRp56zLoimt2RjdFKrDYroxqu+5da6u86qrPTuAzbBZpDcD6f0/W6Pu4ywazeVnxm72IM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 85654288-5ee4-40ee-94f9-08d61cfedf6e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR01MB2699;
x-ms-traffictypediagnostic: DM5PR01MB2699:
x-microsoft-antispam-prvs: <DM5PR01MB2699B4A264B3E8B418AE2A69B41D0@DM5PR01MB2699.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DM5PR01MB2699;BCL:0;PCL:0;RULEID:;SRVR:DM5PR01MB2699;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39840400004)(376002)(346002)(189003)(199004)(486006)(6506007)(53546011)(33656002)(86362001)(81166006)(6916009)(81156014)(2900100001)(54906003)(6246003)(99286004)(478600001)(446003)(4326008)(14444005)(68736007)(305945005)(256004)(11346002)(476003)(2616005)(14454004)(316002)(7736002)(106356001)(2906002)(6512007)(97736004)(53936002)(25786009)(26005)(8936002)(82746002)(5250100002)(3846002)(6116002)(102836004)(5660300001)(186003)(76176011)(105586002)(6436002)(66066001)(229853002)(83716003)(6486002)(36756003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB2699;H:DM5PR01MB2348.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: oxP0a1Pis1DpW5SV1WoHaaPyGFf9VqJ+RknGjJ5rQw2CCZK5oZIAGn+VHxzSD5KsX/WaEVCdT8Qx5S2gqEzO3con8noZilsFbuPTcuS2rIqKqNxnTULCvQsCjcinktIh3VQ+rDUhJDXe8VeMmoozeM3gBfXBo4DyQ66Bdo5tKCgcaxRn+OVPNsSrH+WfpsKjk5VckjEb511edA2XsnwcnDYSgq2Kly2LSDxIDhdGmIB2yI93MoZegysp/rIfpRTJ4+eWicI7HgSIxNVGfYsI6hJD9QpJcrzJo6Z8J2krKFYbWgGdrjoFJ2P3UfKz8u6b3cuRxOoyRHkCx4DLLI6XYJb6+9trmSIv4RRkAB6CTns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <D061C8A3AE55F84DBF2C3151C325DDD4@prod.exchangelabs.com>
MIME-Version: 1.0
X-OriginatorOrg: catalogicsoftware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85654288-5ee4-40ee-94f9-08d61cfedf6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 00:37:11.4403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea3d63e8-dd40-410b-9496-d2ee49ccddc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2699
X-MC-Unique: xG7ZdLJXOjqiV231qHIAIQ-1
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2018, at 2:22 PM, Laura Abbott <labbott@redhat.com> wrote:
>=20
> There's currently a warning about string overflow with strncat:
>=20
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: In function 'ibmvscsis_probe':
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3479:2: error: 'strncat' specifi=
ed
> bound 64 equals destination size [-Werror=3Dstringop-overflow=3D]
>  strncat(vscsi->eye, vdev->name, MAX_EYE);
>  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Switch to a single snprintf instead of a strcpy + strcat to handle this
> cleanly.
>=20
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Make sure there is an extra space in the partition name
> ---
> drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20

Reviewed-by: Bryant G. Ly bly@catalogicsoftware.com

I sent a PR to update my email from bryantly@linux.vnet.ibm.com a week ago.

-Bryant

