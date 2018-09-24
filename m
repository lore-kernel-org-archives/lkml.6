Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91007C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2292087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TLTYclMW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dXit5OYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2292087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeIXQEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:04:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4948 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeIXQEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1537783414; x=1569319414;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NSXiJhLsC4jWikA0EA8OI5CC54em1/HB9H8YxeSgcwg=;
  b=TLTYclMWl8LKOeQmcOc0PsCa8QQSnJb/AXGhNO0knXGv12Cv/v/GHXGD
   tXIPn0Wt/0cLCFcxheteamooB2XggnCRtB0KXPnaTB6QmZ+X9MrQ3MXPh
   XlMHL7zbmzCgZvHxCmvR2ab2PvYpuQ4lXeqxfqmE7FZMTCIOPs6V+/C0R
   KrqFyGgPQ9rn3yLSw1pWp6e2ZCWDB3D5ibwH4EwKpZM6UFI5mb3ewDSHS
   vw2xMT3x/zPH356EKkZh2N/x3V1i2HaSiMroqJVmPYBs4av+o/Yc4+5B+
   4ljsETCIMWBVw76YlNoImga+Ewbvi/Evh+2qwXsz8B8izah8m9wCZpJhl
   A==;
X-IronPort-AV: E=Sophos;i="5.54,297,1534780800"; 
   d="scan'208";a="90408560"
Received: from mail-sn1nam01lp0119.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.119])
  by ob1.hgst.iphmx.com with ESMTP; 24 Sep 2018 18:03:33 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gYBSqI3RCvZo29AjhHxlH0q+KyKnRyOtSj1Q5fhj1g=;
 b=dXit5OYf3VaSDqkKC+nKeh9Z6jhWFLNu2WORkv3f+m4QfckiLxt+irnnua2l313HzrB+G+wcfrKAnI82txGFWmixA2bzmu3jZzmHbbxO03/J+g9ACzhWZjDgE+ipHGaJI2lT7NzTbtwFe75RoL+LuZftqUBi1LC1Vpi+aVhS5s8=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4477.namprd04.prod.outlook.com (52.135.119.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.17; Mon, 24 Sep 2018 10:03:29 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::acfd:8e39:37f4:1151]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::acfd:8e39:37f4:1151%4]) with mapi id 15.20.1143.019; Mon, 24 Sep 2018
 10:03:29 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Sayali Lokhande <sayalil@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>
CC:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V14 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
Thread-Topic: [PATCH V14 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
Thread-Index: AQHUU8/5+XuuyPYED0KkdM/m7LJ4iaT/L9sy
Date:   Mon, 24 Sep 2018 10:03:29 +0000
Message-ID: <SN6PR04MB4925D198F7AE8961254F43C9FC170@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org>,<1537770516-28410-3-git-send-email-sayalil@codeaurora.org>
In-Reply-To: <1537770516-28410-3-git-send-email-sayalil@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [213.57.170.193]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4477;6:jKCaA682XVTqAiTXU5TSFcZYH2h26ipTS18FGEC4ZBQAhJ07sPMqi0Glu0+dL8+H6aBJFiLiwBx+je6YIsbrw7eZqxviUEOO9fdG23qWXo0QZ+J66a4iGKCEcR+ELJ7MBfQHQlytqPcfnrkVT/EynZGfRKrjgeUMLGIEq2LrNSZYPLxzhWm//+jvXf0oMOP1H4lAHSaJp7LNBLqD7ai8+yymKRoSQ1slwnrm3a4Dg+lvI9QMjka8dE1YmeYGo1XvbUb+RevC9mjf5Kp5auQLvDivWVZ0m7NH5rTMNGXy2MnD9ruGJIyKH0GLh+7BN4kTuwcTHZn/QrWioMOYYiGtiCaV91aU9qJPGkYkIbKGlBSrTr1J1PWw7V/bUE81UpwOpdEshYVcHM6hTPBkkclhuCuJZW7+sY26gQaH4fUW0VfJSAtKPC+mnptQFsft0HmMHoc9Q6tzjYjQbCpCv9kaRQ==;5:Le1EyfKyYw8IWfx1VKXqEHW8UTRVCrab0yt6vQ50pj1qWMgOaXzyqA0zl/d3FW9eGArv1sElkHBeYpIwFQg0nEO5uLAMrQ1C5ZzCFsZp27XTomW1TLV158xkaXIt94PQB14hOenv4jwaKKLh7oWgtXGcss21omUwbJk8HfKuRbE=;7:nIUMMS/OZsaeFDIDj3hK6y4o9/h555eiG1PMG9+8mvR1p8Nqo4GTz2//XhfnEplbTQT9wKNbr+guxkV6k3H9N+5REmkDuiM8n9INqCleFv6kXOx4EOra1950Bc4qhHyg5bJKgQQ0p08Mm62pQxzJ6YqM7VR+TC6VIrBfLGIQtdbkg9FdEi8Q9sbxv0jOu/kaNE+xsv1ad40eGIBGCTytWAewOu4RmPxGkIa/YWMeLYOqcF8EP5q2SbjVXdWPiERp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 186f1ec5-9de0-45b2-d2e9-08d62204fa2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4477;
x-ms-traffictypediagnostic: SN6PR04MB4477:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB44779F57F1452F84F3C613BDFC170@SN6PR04MB4477.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN6PR04MB4477;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4477;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(189003)(102836004)(74316002)(7416002)(4326008)(8676002)(86362001)(39060400002)(14444005)(256004)(106356001)(99286004)(5660300001)(68736007)(305945005)(316002)(2201001)(110136005)(54906003)(6246003)(11346002)(6436002)(53936002)(9686003)(55016002)(25786009)(486006)(105586002)(476003)(66066001)(72206003)(478600001)(229853002)(2906002)(446003)(76176011)(71190400001)(7736002)(71200400001)(8936002)(33656002)(6116002)(3846002)(7696005)(81166006)(81156014)(97736004)(2900100001)(14454004)(5250100002)(186003)(2501003)(6506007)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4477;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8fXvTzS4FnrhvK9fsBd1tXUCpvnZ0QtW1uWyqgbMnlARJ1FZV62uCOZ4YpYBrdmEj2lpulDsPPhmZtWSYD51DF5p8cl5z75QeTtRq3ZSpHQxB/xtMFXSVi/jREMLZHNwqd7u9YNS/CN6G5/1UkVasOuzeYOmZn610cyosheY9XX+TQpYuddD4NymkeLSZKhKvNLvSoYlTj+GZJAee2yhnt49TomRht9D2I2jwqfXDb+9LG0NSh4tohn1/8SDNkxyNRwiKhyIfRL9jDUuYwXdsh4y0BNG9tkyENuAlNAv1Sl6iRB30m8bo2EPLfL7ivHjR44+XyyK7cyqKULTw9k/bXMUx7psdbOnAAM69cbyJD4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186f1ec5-9de0-45b2-d2e9-08d62204fa2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 10:03:29.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
>obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o
>ufshcd-core-objs :=3D ufshcd.o ufs-sysfs.o
>+obj-$(CONFIG_SCSI_UFS_PROVISION) +=3D ufs-configfs.o
Isn't ufs-configfs should be part of ufshcd-core? like ufs-sysfs ?


>+static ssize_t ufs_config_desc_show(struct config_item *item, char *buf,
>+                                   u8 index)
>+{
The read part already exist in ufs-sysfs.


>+ssize_t ufshcd_desc_configfs_store(struct config_item *item, const char *=
buf,
>+                                  size_t count, u8 index)
>+{


>+
>+       /*
>+        * First read the current configuration descriptor
>+        * and then update with user provided parameters
>+        */
if originally only lun0 was configured, and you want to configure a new set=
 of luns -=20
luns 8 to 15 (config index 0x1) - won't the read fail in that case?

Thanks,
Avri=
