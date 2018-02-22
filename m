Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbeBVOyg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:54:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:21308 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeBVOye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:54:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="29026140"
From: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
To: "hch@lst.de" <hch@lst.de>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sth@linux.vnet.ibm.com" <sth@linux.vnet.ibm.com>,
        "Herring, Jan-kristian Augustin"
        <jan-kristian.augustin.herring@intel.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: regression: SCSI/SATA failure
Thread-Topic: regression: SCSI/SATA failure
Thread-Index: AQHTq+0L1oGrAlqZ9kOOjux0b2hi1Q==
Date: Thu, 22 Feb 2018 14:54:31 +0000
Message-ID: <1519311270.2535.53.camel@intel.com>
Reply-To: "Bityutskiy, Artem" <artem.bityutskiy@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.68.39]
Content-Type: text/plain; charset="utf-8"
Content-ID: <392A370C8BDD5E45AD05738F3E18335D@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MEseec030179

Hi Christoph,

one of our test box Skylake servers does not boot with v4.16-rcX.
Bisection lead us to this commit:

84676c1f21e8 genirq/affinity: assign vectors to all possible CPUs

Reverting this single commit fixes the problem.

The server is a Dell R640 machine with the latest Dell BIOS. It has a
single SATA SSD and we do not use raid, even though the system does
have a megaraid controller.

Are you aware of this issue? Below is the failure message and the full
dmesg with some debugging boot parameters is here:

https://pastebin.com/raw/tTYrTAEQ

[  201.706075] sd 14:2:0:0: [sda] tag#0 task abort called for scmd(00000000c342d874)
[  201.720357] sd 14:2:0:0: [sda] tag#0 CDB: Read(10) 28 00 0d e7 ff 80 00 00 08 00
[  201.734621] sd 14:2:0:0: task abort: FAILED scmd(00000000c342d874)
[  201.754134] sd 14:2:0:0: target reset called for scmd(00000000c342d874)
[  201.767566] sd 14:2:0:0: [sda] tag#0 megasas: target reset FAILED!!
[  201.780690] sd 14:2:0:0: [sda] tag#0 Controller reset is requested due to IO timeout
[  201.780690] SCSI command pointer: (00000000c342d874)  SCSI host state: 5      SCSI 
[  201.809709] IO request frame:
[  201.809709] 
[  201.809710] f1000000 
[  201.827987] 00000000 
[  201.836901] 00000000 
[  201.846047] 5d880000 
[  201.855161] 00600002 
[  201.864093] 00000020 
[  201.872746] 00000000 
[  201.881168] 00001000 
[  201.889432] 
[  201.889432] 
[  201.897570] 00000000 
[  201.912011] 0000000a 
[  201.919897] 00000000 
[  201.927608] 00000000 
[  201.935275] 00000000 
[  201.943047] 00000000 
[  201.950516] 00000000 
[  201.957709] 02000000 
[  201.964776] 
[  201.964776] 
[  201.971731] e70d0028 
[  201.983967] 000080ff 
[  201.990676] 00000008 
[  201.997192] 00000000 
[  202.003611] 00000000 
[  202.009812] 00000000 
[  202.015847] 00000000 
[  202.021770] 00000000 
[  202.027576] 
[  202.027576] 
[  202.033382] 00140012 
[  202.043209] 00000009 
[  202.048521] 0de7ff80 
[  202.053711] 00000000 
[  202.058818] 00000008 
[  202.063850] 00000000 
[  202.068797] 00020100 
[  202.073549] 00000000 
[  202.078131] 
[  202.078131] 
[  202.082708] beb56000 
[  202.089903] 0000002f 
[  202.094106] 00001000 
[  202.098230] 40000000 
[  202.102238] 00000000 
[  202.106134] 00000000 
[  202.109878] 00000000 
[  202.113456] 00000000 
[  202.117008] 
[  202.117008] 
[  202.120545] 00000000 
[  202.126100] 00000000 
[  202.129656] 00000000 
[  202.133191] 00000000 
[  202.136716] 00000000 
[  202.140241] 00000000 
[  202.143767] 00000000 
[  202.147264] 00000000 
[  202.150772] 
[  202.150772] 
[  202.154257] 00000000 
[  202.159702] 00000000 
[  202.163206] 00000000 
[  202.166706] 00000000 
[  202.170204] 00000000 
[  202.173697] 00000000 
[  202.177186] 00000000 
[  202.180659] 00000000 
[  202.184135] 
[  202.184135] 
[  202.187592] 00000000 
[  202.192952] 00000000 
[  202.196440] 00000000 
[  202.199892] 00000000 
[  202.203349] 00000000 
[  202.206798] 00000000 
[  202.210252] 00000000 
[  202.213691] 00000000 
[  202.217140] 

-- 
Best Regards,
Artem Bityutskiy
---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
