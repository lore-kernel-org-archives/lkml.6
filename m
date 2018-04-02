Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754787AbeDBWtx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:49:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35300 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754535AbeDBWtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:49:47 -0400
X-IronPort-AV: E=Sophos;i="5.48,397,1517846400";
   d="scan'208";a="178126564"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Thread-Topic: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Thread-Index: AQHTyrUNkNkjnUv7yk+FmjLOLTu6JKPt+B6AgAAAm4CAAAzSAIAAAWEAgAACJYCAAAIlgIAACSYA
Date: Mon, 2 Apr 2018 22:49:43 +0000
Message-ID: <e2b9b49876c9979cdadef1a04904b5899cf34b1a.camel@wdc.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
         <20180402190120.GD388343@devbig577.frc2.facebook.com>
         <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
         <20180402211047.GF388343@devbig577.frc2.facebook.com>
         <afef8f4812b357deeadc0999f4c85d7b0049b738.camel@wdc.com>
         <20180402220136.GI388343@devbig577.frc2.facebook.com>
         <6d6985b8d95317aa5572809f1b987c45e932c5b2.camel@wdc.com>
         <20180402221657.GL388343@devbig577.frc2.facebook.com>
In-Reply-To: <20180402221657.GL388343@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0751;7:KF2OHbKld9xdUNIgqvInVKnyqvXzvKZMj2isH1m2hWqHT63D5jEVhXlvlm6GldHwQazm8go8FoEVg2ne/ISZvfIZbKMUwSkJghcnfFRqztwzS5oK/nmd55MTLG44QmJZpR+XQbvZymsKVakYNzutTJHyNeVN0ogks/EiYYAuPkkggjQLiNmlYoA1qrXL7+u+Fkn/h1CcRC0sgISZK04JCH8cQdR/YgwSQVmJG1k25D0iFz+5geZ6kOcFsic8qmHE;20:HvQQbZC2BM6FgRRbRNbj3fUPdXteBpCcCEAZXwDN3dZ482noADZaEFatSQb2M1NrvFBMl+3aOMgERni/8rrHnDj6Jz7bBBIaRVkXW396lNjOZdZGEUmiDYKhI7ZMw70sBNAUKAGSHv70oa9Ir7LEj07URsQLvdnmlrn6OLBFnts=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bead1b59-ee05-4c7e-1bff-08d598ec06db
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0751;
x-ms-traffictypediagnostic: MWHPR04MB0751:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0751A48972E22BD1D1482E7298A60@MWHPR04MB0751.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0751;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0751;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(39860400002)(366004)(396003)(189003)(377424004)(199004)(478600001)(8676002)(2501003)(81156014)(1730700003)(6506007)(86362001)(476003)(2351001)(5250100002)(2616005)(5660300001)(486005)(6512007)(81166006)(3280700002)(486005)(6246003)(26005)(11346002)(66066001)(25786009)(102836004)(99286004)(53936002)(97736004)(186003)(3660700001)(68736007)(93886005)(106356001)(72206003)(3846002)(6916009)(6116002)(316002)(446003)(14454004)(2900100001)(8936002)(105586002)(305945005)(118296001)(5640700003)(6436002)(7736002)(4326008)(6486002)(2906002)(54906003)(36756003)(76176011)(229853002)(59450400001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0751;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1afFipC/t0ps82WmmzwVsOGs8shW8rELcd1Nd4l+0EPACTwK0E4Zn1j1zo/O6VnFRNj6BKINe7HfMBMGr8Jwy19RbXdTBfEWqa1S9+JQSn71JuzRAPwyraQQkR/raZEqo5P/fPYIbfbK/kFApDvNggwevhAAItBx2NOfVuwo5L0ayz59pwyYHw8bp3MI8HjlrT8Sox+NYKj/5SdOCgZk32hkATJiSRohC7qFPi/uCjKd6w7jzz+GblzcS6slCNEXV96roS7NbQUkf0z5JLCtasrvIBytTNIOyOrf+0HrP+ehJw5g07eukIwNtv14mynmTOqxTbC7STGeJNm0K0HpeSdwR4/aEBuIBRCwEpYaP16DFIqBm69/8r7mGMiJUYEHMTzgoNWtqJA9QwKq+1sePCZRWr3O0cBMmVRvBzTAff4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F33F8FB7F44E47439ADBE7E2FB5D904A@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bead1b59-ee05-4c7e-1bff-08d598ec06db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 22:49:43.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0751
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32MnxEu025240

On Mon, 2018-04-02 at 15:16 -0700, tj@kernel.org wrote:
> AFAIK,
> there's one non-critical race condition which has always been there.
> We have a larger race window for that case but don't yet know whether
> that's problematic or not.  If that actually is problematic, we can
> figure out a way to solve that but such effort / added complexity
> doesn't seem justified yet.  No?

Hello Tejun,

Some important block drivers systematically return BLK_EH_RESET_TIMER
from their timeout handler, e.g. the virtio-scsi initiator driver. What
will the consequence be for these drivers if a blk_mq_complete_request()
call is ignored? Will the request for which the completion was ignored
get stuck?

Thanks,

Bart.
