Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91920C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A7920841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=catalogicsoftware.com header.i=@catalogicsoftware.com header.b="bAACXdDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A7920841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=catalogicsoftware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeJKUdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:33:16 -0400
Received: from us-smtp-delivery-107.mimecast.com ([216.205.24.107]:54978 "EHLO
        us-smtp-delivery-107.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbeJKUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catalogicsoftware.com; s=mimecast20180821; t=1539263167; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=RzCXVARKFlIgoxJ8tupSpVPfhLNyFRdEEcXev2tuh2w=; b=bAACXdDXTcjkphPNRW36/J1vI6cNWPuNqfX1dXMm4sNPUi/6BlzY7o29y4uzKvwa8woMVzvaeB7HIZOmfvz39e0ec6xA45SYIAKG8meC2Pd9mm3eED4Xf9CDzz1YGCnOIf3+0U/wW5B6miD3GSh/bOGhmDd48laGinBx9OxGyq8=
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01lp0180.outbound.protection.outlook.com [216.32.181.180])
 (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-213-UuxzpsyTOlOytWM1giTzng-1; Thu, 11 Oct 2018 09:06:05 -0400
Received: from DM5PR01MB2348.prod.exchangelabs.com (10.168.192.138) by
 DM5PR01MB3225.prod.exchangelabs.com (10.172.189.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Thu, 11 Oct 2018 13:05:59 +0000
Received: from DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::a16f:30df:2f13:edb1]) by DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::a16f:30df:2f13:edb1%3]) with mapi id 15.20.1228.020; Thu, 11 Oct 2018
 13:05:59 +0000
From:   "Ly, Bryant" <bly@catalogicsoftware.com>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>
CC:     Mike Christie <mchristi@redhat.com>,
        target-devel <target-devel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
Thread-Topic: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
Thread-Index: AQHUYEiZqcAaFWCqE06ZzWwpCq+UtqUYtGqAgADZNoCAAHgcAA==
Date:   Thu, 11 Oct 2018 13:05:59 +0000
Message-ID: <F43269BA-4D7B-486C-87C6-0FB48FF890EA@catalogicsoftware.com>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
 <5BBE2FBF.7080804@redhat.com>
 <1539237365.6150.32.camel@haakon3.daterainc.com>
In-Reply-To: <1539237365.6150.32.camel@haakon3.daterainc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [96.42.214.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR01MB3225;20:zQtuw4Zyqx4LRXacOIDEU44NQvDzVtQTEGFsq46W3VWCFg61u24vZ/YCwQo3/TVfLXKJQylJnuRuxj8+RTvr03MCggJATl/fqxnezdAE0PWdfnHZotwykToC1m8RN340kW5bOWCFM3mxmnwJcF9aRcMIsPh7UzBqZZIkeAuuLMc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f40278a6-7e00-4f6e-4388-08d62f7a4a46
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR01MB3225;
x-ms-traffictypediagnostic: DM5PR01MB3225:
x-microsoft-antispam-prvs: <DM5PR01MB3225CAC5E4F45D1410213D93B4E10@DM5PR01MB3225.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201703061421075)(201703161042150)(20161123560045)(20161123562045)(6042181)(201708071742011)(7699051);SRVR:DM5PR01MB3225;BCL:0;PCL:0;RULEID:;SRVR:DM5PR01MB3225;
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(7416002)(6916009)(33656002)(54906003)(7736002)(97736004)(4001150100001)(14454004)(5660300001)(486006)(102836004)(26005)(446003)(11346002)(476003)(2616005)(93886005)(186003)(6506007)(99286004)(53546011)(83716004)(256004)(14444005)(5250100002)(2900100001)(305945005)(105586002)(106356001)(66066001)(76176011)(229853002)(86362001)(6486002)(2906002)(4326008)(82746002)(71200400001)(71190400001)(6116002)(36756003)(3846002)(68736007)(6246003)(81156014)(6436002)(6512007)(53936002)(81166006)(25786009)(498600001)(8936002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB3225;H:DM5PR01MB2348.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lsvFrhE69QKtFlGoBTFXE8hoDeg2fSztkq8U1j0WB1H+gE0lBtMb7nKRUgIgxTGNoU1eWwQlwFJA5YXl8784t6RjYRjECgOEQjizmgDO12eDOkuNkCiXD22rSjk6Ig4xKFoPP0D8zARdj+zMIwHMe28bTC/Hpd+8tzlUV8WyBpEsK+sdu9aQKX6JqpG4bz0s0f5z/rmZmfRBlgDGFhtoMPCCpW7oFTybcMf2qBZOYGFkVTY2ASTe+VC6fDu30Td114O8YzFCBF0YvOStmEglHet0R9NzHGAEnHGCeS/jInkj7jb3sReKyLFE4jXYo5WU0A7yyTacr/Wnv8c6eWc2HSZduVWnQ5cPzPeLAEUnbaM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <7D799E9702521C439DB90D96510B7D4D@prod.exchangelabs.com>
MIME-Version: 1.0
X-OriginatorOrg: catalogicsoftware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40278a6-7e00-4f6e-4388-08d62f7a4a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 13:05:59.5876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea3d63e8-dd40-410b-9496-d2ee49ccddc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB3225
X-MC-Unique: UuxzpsyTOlOytWM1giTzng-1
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 11, 2018, at 12:56 AM, Nicholas A. Bellinger <nab@linux-iscsi.org>=
 wrote:
>=20
> Hello MNC & Co,
>=20
> On Wed, 2018-10-10 at 11:58 -0500, Mike Christie wrote:
>> On 10/09/2018 10:23 PM, Nicholas A. Bellinger wrote:
>>> From: Nicholas Bellinger <nab@linux-iscsi.org>
>>>=20
>>> With the addition of commit 00d909a107 in v4.19-rc, it incorrectly assu=
mes no
>>> signals will be pending for task_struct executing the normal session sh=
utdown
>>> and I/O quiesce code-path.
>>>=20
>=20
> <SNIP>
>=20
>>> diff --git a/drivers/target/target_core_transport.c b/drivers/target/ta=
rget_core_transport.c
>>> index 86c0156..fc3093d2 100644
>>> --- a/drivers/target/target_core_transport.c
>>> +++ b/drivers/target/target_core_transport.c
>>> @@ -2754,7 +2754,7 @@ static void target_release_cmd_kref(struct kref *=
kref)
>>> =09if (se_sess) {
>>> =09=09spin_lock_irqsave(&se_sess->sess_cmd_lock, flags);
>>> =09=09list_del_init(&se_cmd->se_cmd_list);
>>> -=09=09if (list_empty(&se_sess->sess_cmd_list))
>>> +=09=09if (se_sess->sess_tearing_down && list_empty(&se_sess->sess_cmd_=
list))
>>=20
>> I think there is another issue with 00d909a107 and ibmvscsi_tgt.
>>=20
>> The problem is that ibmvscsi_tgt never called
>> target_sess_cmd_list_set_waiting. It only called
>> target_wait_for_sess_cmds. So before 00d909a107 there was a bug in that
>> driver and target_wait_for_sess_cmds never did what was intended because
>> sess_wait_list would always be empty.
>>=20
>> With 00d909a107, we no longer need to call
>> target_sess_cmd_list_set_waiting to wait for outstanding commands, so
>> for ibmvscsi_tgt will now wait for commands like we wanted. However, the
>> commit added a WARN_ON that is hit if target_sess_cmd_list_set_waiting
>> is not called, so we could hit that.
>>=20
>> So I think we need to add a target_sess_cmd_list_set_waiting call in
>> ibmvscsi_tgt to go along with your patch chunk above and make sure we do
>> not trigger the WARN_ON.
>>=20
>=20
> Nice catch.  :)
>=20
> With target_wait_for_sess_cmd() usage pre 00d909a107 doing a list-splice
> in target_sess_cmd_list_set_waiting(), this particular usage in
> ibmvscsi_tgt has always been list_empty(&sess->sess_wait_list) =3D true
> (eg: no se_cmd I/O is quiesced, because no se_cmd in sess_wait_list)
> since commit 712db3eb in 4.9.y code.
>=20
> That said, ibmvscsi_tgt usage is very similar to vhost/scsi in the
> respect individual /sys/kernel/config/target/$FABRIC/$WWN/$TPGT/
> endpoints used by VMs do not remove their I_T nexus while the VM is
> active.
>=20
> So AFAICT, ibmvscsi_tgt doesn't strictly need target_sess_wait_for_cmd()
> at all if this is true.
>=20

VMs do not remove the I_T nexus while the VM is active, so we can remove
the target_wait_for_sess_cmd() call.=20

-Bryant

