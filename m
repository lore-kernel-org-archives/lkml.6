Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8FBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6BA206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 20:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LrBGhWGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfAIU4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:56:33 -0500
Received: from mail-eopbgr1300107.outbound.protection.outlook.com ([40.107.130.107]:23424
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726581AbfAIU4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 15:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWs4puKjwgggkl4pukazQdOGMH+W7NRdQx7hDUYyT9M=;
 b=LrBGhWGqruC5lBX3LnaPE0cfeuc9v5YRkJF+wm1pXF70JBv5Kb0/InJ96muxufr1G+j+SoDGNnaGG8/1CODTjQ30jvlteW4aNrwF7vgJoxt4hna4IM8JLeXfslCwK8xrvFlGt6YPRuXpTeilF2chjnqLTV1e/2R10yzCJ8a88Q8=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0171.APCP153.PROD.OUTLOOK.COM (10.170.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.4; Wed, 9 Jan 2019 20:56:06 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::99da:e3db:6b66:c8d4%6]) with mapi id 15.20.1537.005; Wed, 9 Jan 2019
 20:56:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        'Stephen Hemminger' <stephen@networkplumber.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        vkuznets <vkuznets@redhat.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        'Dan B' <dan@structuredgrid.net>
Subject: [PATCH][re-post] vmbus: fix subchannel removal
Thread-Topic: [PATCH][re-post] vmbus: fix subchannel removal
Thread-Index: AdSoXEnKO2XAWbtbQvW/FSTw6hHRGg==
Date:   Wed, 9 Jan 2019 20:56:06 +0000
Message-ID: <PU1P153MB0169D32ECDF37A2DB55AD485BF8B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-09T20:56:03.0688691Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:7:984d:e146:ff3b:fc3c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0171;6:xz8yXU+FvHukDyZyOqqi7qr0DvBzszTKcR9xvUfWQLVDJLNLsnxav84ri9yrtUfS/2epYvy7ZF5PPxNCTsiZ5SInXVK8Ntfb4oD3SGI57d6ZCaYC5MRLt0uCnlPozDKunQeinbEgPj7EuAADfVDuzOYGbtf+refyXQeD7dUaw6jUKinUS7ZHm/dRlkAjrB7tqMIYkAXNOMCMexzVZFVFG3aK6MercbScB2NnC7TJniJ6hqfbzimpaqcA9Kpdd6DGxZsTVIe2y1u6Q4PRCpbtnvBnT1GGHb3F+L5sd7cayw38QXKQmZSmljIQ/s5eskp5X/vkx8/JqBjDLK7lW4LhzePP1BQRlBSMl3hC7XuU4dusVRPfHgKrOcrKCCNjciMe4IHshXhH183Xcmgy7m6+j0zcvgsgjCqgZAn9rpNT1V48R+zcwdt5caMXb+efID8WkzGcCBH+uiT+tqfV4j3y4w==;5:Tuw9yXTfa2RLzy7HBCJkIgEd6BtZPjOHfmYmAsYEIWPQUDDd8atIeJOm1GzSjT3X+C1wpLhTUFwGS10d5cCNjF4Xl7x2Qsh18Y7MPWzwxyBuVGk6adpQQCqZ7AsEZzRib43KRB4qBnt8qYySmDzcmUbbGZ5+mx9+JW3U6V7bFN42Itx9cvzOXTDqq6pc7MAfBvWrNDbtF7BAXFY+FQovBg==;7:K16ioT0+HJXxQi9Q9iBSZDGetFd8lQ+LAJJQXNML+8VFalhsRG9OadIDmZn74tEjuZ1ZL+6hZWgPUF7Nj1XWT+qeHtvocqA+hbNPShzXPPnKP/Kal7IJb0sSB1tFCNnU7yeg0A7TRIJlqC81xuGNkA==
x-ms-office365-filtering-correlation-id: 54f1e408-30ba-486f-c938-08d67674e01b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0171;
x-ms-traffictypediagnostic: PU1P153MB0171:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB017170C04D827ACDDCD9DA0EBF8B0@PU1P153MB0171.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(2018427008)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0171;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0171;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(71200400001)(71190400001)(68736007)(6306002)(9686003)(53936002)(110136005)(476003)(2906002)(10290500003)(6116002)(14444005)(256004)(4326008)(25786009)(8990500004)(55016002)(81166006)(8936002)(81156014)(575784001)(6436002)(54906003)(86362001)(8676002)(6636002)(86612001)(97736004)(486006)(1511001)(7696005)(10090500001)(33656002)(46003)(5660300001)(7416002)(14454004)(966005)(478600001)(22452003)(316002)(7736002)(305945005)(106356001)(99286004)(105586002)(6346003)(74316002)(6506007)(186003)(102836004)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0171;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vtsw9jl2z+tXfYoRhXMXplXTwejsqRBKxQfhzrhbIJGWPX63hjZKB329vS1BbpDhRKUJkswKP2p8IDIys1qtDEEuhw0YpSQWQH1APmw2TLgKH8J+kt1MoaNsxKSuVGHN2kXitbULuhOXjhmgjjC9RH6sWZa1zJNHrNls7iSxgZKx3M9477ChBkvaosf1kXdDAEWVut0Mm8uEIXrcJfFPZOB1wcUmd9sankMTmB+8qKvLQ8y6wt5iR4W7QlCoSPCs7RL0z81DKQaRVHNp0Cjbc4KU1UWNumeGaI3zzJ1rj2OpCdD6EP0IJ6nPlZG/IyJ6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f1e408-30ba-486f-c938-08d67674e01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 20:56:06.2701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The changes to split ring allocation from open/close, broke
the cleanup of subchannels. This resulted in problems using
uio on network devices because the subchannel was left behind
when the network device was unbound.

The cause was in the disconnect logic which used list splice
to move the subchannel list into a local variable. This won't
work because the subchannel list is needed later during the
process of the rescind messages (relid2channel).

The fix is to just leave the subchannel list in place
which is what the original code did. The list is cleaned
up later when the host rescind is processed.

Without the fix, we have a lot of "hang" issues in netvsc when we
try to change the NIC's MTU, set the number of channels, etc.

Fixes: ae6935ed7d42 ("vmbus: split ring buffer allocation from open")
Cc: stable@vger.kernel.org
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>

---

The patch was firstly posted on Dec-7 2018:
https://www.spinics.net/lists/linux-driver-devel/msg120802.html
but it looks it's neglected.

Now let me rebase it to v5.0-rc1: the line "channel->num_sc =3D 0;"
in the original patch must be removed due to
4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoin=
g_channel()")

When the patch is backported to v4.20.1, there will be a conflict because
v4.20.1 doesn't have 4d3c5c69191f. I suggest we cherry-pick 4d3c5c69191f
into v4.20.1, before we backport this patch.

 drivers/hv/channel.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index ce0ba20..bea4c98 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -701,19 +701,12 @@ static int vmbus_close_internal(struct vmbus_channel =
*channel)
 int vmbus_disconnect_ring(struct vmbus_channel *channel)
 {
 	struct vmbus_channel *cur_channel, *tmp;
-	unsigned long flags;
-	LIST_HEAD(list);
 	int ret;
=20
 	if (channel->primary_channel !=3D NULL)
 		return -EINVAL;
=20
-	/* Snapshot the list of subchannels */
-	spin_lock_irqsave(&channel->lock, flags);
-	list_splice_init(&channel->sc_list, &list);
-	spin_unlock_irqrestore(&channel->lock, flags);
-
-	list_for_each_entry_safe(cur_channel, tmp, &list, sc_list) {
+	list_for_each_entry_safe(cur_channel, tmp, &channel->sc_list, sc_list) {
 		if (cur_channel->rescind)
 			wait_for_completion(&cur_channel->rescind_event);
=20
--=20
2.7.4

