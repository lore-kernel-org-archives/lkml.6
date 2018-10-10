Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9765C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484EF2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=catalogicsoftware.com header.i=@catalogicsoftware.com header.b="J9c0U4CR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484EF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=catalogicsoftware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbeJJLXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:23:11 -0400
Received: from us-smtp-delivery-107.mimecast.com ([63.128.21.107]:59204 "EHLO
        us-smtp-delivery-107.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbeJJLXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catalogicsoftware.com; s=mimecast20180821; t=1539144180; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding: in-reply-to:in-reply-to:references:references; bh=lNvwQsz0ITHIDqJj/fFGqYRg3TM2ZW8msscpdgaNx0o=; b=J9c0U4CRM3OJUwaBHOd23U6T1AU5vtZL6odO0DemRvu//hFZy0KADstTMyUhec7e5dsEGxVg/aqL5pXQIH3XKpfUDB1fIAaPs5QdthR5JSfXP8pkRYyapyx39aSPvMngG9yR8luzPIQB5Dt90HpHcPanF+wpyqD3nLEAPSLTuQ0=
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01lp0120.outbound.protection.outlook.com [207.46.163.120])
 (Using TLS) by us-smtp-1.mimecast.com with ESMTP id
 us-mta-145-kSgJyLRVPPqSAanGAzqssA-1; Wed, 10 Oct 2018 00:01:20 -0400
Received: from DM5PR01MB2348.prod.exchangelabs.com (10.168.192.138) by
 DM5PR01MB2444.prod.exchangelabs.com (10.168.193.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Wed, 10 Oct 2018 04:01:17 +0000
Received: from DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::a16f:30df:2f13:edb1]) by DM5PR01MB2348.prod.exchangelabs.com
 ([fe80::a16f:30df:2f13:edb1%3]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 04:01:17 +0000
From:   "Ly, Bryant" <bly@catalogicsoftware.com>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>
CC:     target-devel <target-devel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
Thread-Topic: [PATCH 2/2] target: Fix target_wait_for_sess_cmds breakage with
 active signals
Thread-Index: AQHUYEiZqcAaFWCqE06ZzWwpCq+UtqUX2zcA
Date:   Wed, 10 Oct 2018 04:01:17 +0000
Message-ID: <A95B1AA1-D330-43E6-8F80-71582B9365D8@catalogicsoftware.com>
References: <1539141790-13557-1-git-send-email-nab@linux-iscsi.org>
 <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
In-Reply-To: <1539141790-13557-3-git-send-email-nab@linux-iscsi.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [96.42.214.145]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR01MB2444;20:mYoC4nK5a3BFz4xlI/s8/SiYYs553GdIqiDmyJRmKtu8y8ouyinm9gEZlh5GWdCsw0QORckGRJC/c6VbCk+IMqYfVpxIX7E0d7PmxjG5+wFTAIUSp0IX7tX5jZbXLrZVLBtXQASurV58KDqBMCgpUkPtCvzpYDA3qJg/VyzWSGw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 83cbb00b-5d30-4e86-6c04-08d62e650785
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR01MB2444;
x-ms-traffictypediagnostic: DM5PR01MB2444:
x-microsoft-antispam-prvs: <DM5PR01MB24440D7F1D47CC8BD60B2916B4E00@DM5PR01MB2444.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(213716511872227)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:DM5PR01MB2444;BCL:0;PCL:0;RULEID:;SRVR:DM5PR01MB2444;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(366004)(39850400004)(199004)(189003)(36756003)(33656002)(2900100001)(71190400001)(4326008)(53936002)(97736004)(102836004)(71200400001)(106356001)(6512007)(105586002)(68736007)(6916009)(229853002)(82746002)(5660300001)(6506007)(76176011)(26005)(83716004)(6436002)(53546011)(66066001)(99286004)(6486002)(186003)(5250100002)(7736002)(8676002)(3846002)(476003)(2616005)(81166006)(11346002)(25786009)(8936002)(446003)(14444005)(14454004)(81156014)(256004)(2906002)(86362001)(6116002)(6246003)(316002)(486006)(7416002)(478600001)(54906003)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR01MB2444;H:DM5PR01MB2348.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YNnHQ4jAyIRRP5PrNGYglgjk1OnLHTol5vMCW/u48yP8ks1UZUVIuhW4LQbUSYEqQuahsJbk++4Dx3oOJr4a/r2uHFo6XzfHqUEisDnW88F34JkhUsifnYtzLdMD1jWJMCMHWl70mIQIm5EOepwvguI4Cc2XRY93RSoqfDsw4CZz8BAV0mGVyoDQqsOgXu12iNrFyZNTXzox5ihT7EFLwl4yq2KghSq0DbmUUEPoBuVbw9Cm6yWbUzd4mPgINuFaQTkTiD5vfd0AbAVN7VQxB6/BYctXGxc09jP0i7tIiO9tP5rnOT+W646i2Xhw5jEbiWHaaZxMCZmbcaBdu4kBwWaeLaYhlgVrCncpXwAQRv4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <16B5F183E7182944B5C30EBB0DEE26A6@prod.exchangelabs.com>
MIME-Version: 1.0
X-OriginatorOrg: catalogicsoftware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cbb00b-5d30-4e86-6c04-08d62e650785
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 04:01:17.0411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea3d63e8-dd40-410b-9496-d2ee49ccddc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2444
X-MC-Unique: kSgJyLRVPPqSAanGAzqssA-1
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 9, 2018, at 10:23 PM, Nicholas A. Bellinger <nab@linux-iscsi.org> =
wrote:
>=20
> From: Nicholas Bellinger <nab@linux-iscsi.org>
>=20
> With the addition of commit 00d909a107 in v4.19-rc, it incorrectly assume=
s no
> signals will be pending for task_struct executing the normal session shut=
down
> and I/O quiesce code-path.
>=20
> For example, iscsi-target and iser-target issue SIGINT to all kthreads as
> part of session shutdown.  This has been the behaviour since day one.
>=20
> As-is when signals are pending with se_cmds active in se_sess->sess_cmd_l=
ist,
> wait_event_interruptible_lock_irq_timeout() returns a negative number and
> immediately kills the machine because of the do while (ret <=3D 0) loop t=
hat
> was added in commit 00d909a107 to spin while backend I/O is taking any
> amount of extended time (say 30 seconds) to complete.
>=20
> Here's what it looks like in action with debug plus delayed backend I/O
> completion:
>=20
> [ 4951.909951] se_sess: 000000003e7e08fa before target_wait_for_sess_cmds
> [ 4951.914600] target_wait_for_sess_cmds: signal_pending: 1
> [ 4951.918015] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 0
> [ 4951.921639] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 1
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 2
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 3
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 4
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 5
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 6
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 7
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 8
> [ 4951.921944] wait_event_interruptible_lock_irq_timeout ret: -512 signal=
_pending: 1 loop count: 9
>=20
> ... followed by the usual RCU CPU stalls and deadlock.
>=20
> There was never a case pre commit 00d909a107 where wait_for_complete(&se_=
cmd->cmd_wait_comp)
> was able to be interruptted, so to address this for v4.19+ moving forward=
 go ahead and
> use wait_event_lock_irq_timeout() instead so new code works with all fabr=
ic drivers.
>=20
> Also for commit 00d909a107, fix a minor regression in target_release_cmd_=
kref()
> to only wake_up the new se_sess->cmd_list_wq only when shutdown has actua=
lly
> been triggered via se_sess->sess_tearing_down.
>=20
> Fixes: 00d909a107 ("scsi: target: Make the session shutdown code also wai=
t for commands that are being aborted")
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Mike Christie <mchristi@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Tested-by: Nicholas Bellinger <nab@linux-iscsi.org>
> Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
> ---
> drivers/target/target_core_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Bryant G. Ly <bly@catalogicsoftware.com>

-Bryant

