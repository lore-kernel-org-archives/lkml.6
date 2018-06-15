Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 23B23C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A5208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="KTBct/fI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8A5208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965747AbeFOKQX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:16:23 -0400
Received: from mail-db5eur01on0094.outbound.protection.outlook.com ([104.47.2.94]:38179
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965713AbeFOKQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v/OUkB+Og8OPGTdelaxuTFUpkMvpasYRWWPU1jrrbg=;
 b=KTBct/fI74/Fhumiw98HSIFwLj3CC1WFarHtYDwh1ijuallpNkjyt/n+ytw6ImglnyrzJvkc3uSXHA3f9SczP87v2dI5vZY2o/gUt75YRKV6s5DYbz0IFgCCCEehisjd9+bYeqEDfYXQ9WnZT3DuWXjLmCazh0RTWFhLhMMKP0Q=
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2460.eurprd02.prod.outlook.com (2603:10a6:3:82::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Fri, 15 Jun 2018 10:16:09 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 11/11] i2c: rename i2c_lock_adapter to i2c_lock_root
Date:   Fri, 15 Jun 2018 12:15:06 +0200
Message-Id: <20180615101506.8012-12-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180615101506.8012-1-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0248.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::24) To HE1PR0201MB2460.eurprd02.prod.outlook.com
 (2603:10a6:3:82::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78058383-b365-4c8c-7224-08d5d2a90405
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;3:yDN7wgZDgT56JVStTpz7hm9e2FecH9qi6uSA+NA/2aEGnPHCFqhJJ+zSzClRbJbrjAlJYsiT+5SktVIPCT5r22gTXMVKjaYHpRA6x708I0Izjt7RLzAbJBppKxknqdy/l0J0Xiamkac3Ud0pnnj3/k5UkQKF9VwAlBrZiIOjv0ILKBXcIYkEaO+SbBvCTHrxMOKrJwhvChP/qj9SrS/NYSsfjy8PkvfIBRB3SM90/yiFj5DU/ekKPKfitMnvYl8V;25:J6pscq0FMkR5Tu6+iT9cR5jMAd5+aTUAIhosnu0qfdutT5We4fpTYJ9og+B9cEtnJKRY+t+90yT+3HTuYr5HCoG4op6GEH4yPBoNuvqbUbrJgKQxlCkllBHDQsN/fGS4senQJw4gj4Hby0e1Gw2c+C6l7vAZqvTtb6QF01booJMsJ01RoZPR1uBtbK+uZsjYkE1r956FZsVrPdVeUNk2GYtMvpKkjNhclGKo23NBklta94BsiPj4kslaK5T8LFr3M1bEbPK+WuJOlExwptXfG89vzMTDJafZ48Gq5GrmKS97eo5oTstj3UVTM3AWA4PQtfVYHoTW2b/aSw+lToSbTQ==;31:eyBu6o6somODfhUwWN94vqywlRKPE2edLIky1Vyrm7Ul6o/IazRjstLs5KRgBBvbOj1WX87p1jeBxKkGjdaw//4ppOaMXG6MHZpA8ZSQTOa82DcGMa43V/FDor1dL6GP9pJG2g/QgxECJg8Fsh7lQ+10dzTLCjNLu608JE+gaMboBhAxSeotuxP2thSv5VeqDbT9X0cHjH20NyW9zBTTZ1GLFrRUIOLVk+MFePxCoog=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2460:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB246003C7DDB3AD6DB7AA439ABC7C0@HE1PR0201MB2460.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2460;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2460;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;4:y5A2f3LW6RpQCUcqHET7QDOrAL91L8QrMdg4jS7DIVVfeBgZLfTxV/gR0WBOTx2Aee+2+x40D96MtGI8nXMvb0xSEQDffb0vfbNQk5I9DBxlHlVWl+BpqqX2z1fxWGXEbdXxMMp+Mxyo+QbivjM7yMh4bGQLm8NRG2kM4I5JPLuVWg9Q11s3w63XYDL4xI25gngnhlWqN8Cmgso3l/UFh3YK9WsqZlXfWLSNr741JVO7IzczffaekVoG9CMHi+q0qi3JmASwT5dO3Sn4klvIqA==
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(1496009)(366004)(346002)(376002)(396003)(39840400004)(39380400002)(199004)(189003)(186003)(575784001)(16526019)(97736004)(50466002)(386003)(50226002)(68736007)(81166006)(8676002)(74482002)(26005)(52116002)(6666003)(478600001)(51416003)(2351001)(81156014)(59450400001)(8936002)(6506007)(2906002)(76176011)(15760500003)(6116002)(3846002)(1076002)(6916009)(48376002)(86362001)(7416002)(7406005)(106356001)(66066001)(2361001)(8666007)(305945005)(4326008)(39060400002)(53936002)(36756003)(316002)(5660300001)(446003)(476003)(7736002)(105586002)(6486002)(6512007)(11346002)(54906003)(956004)(47776003)(25786009)(2616005)(486006)(16586007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2460;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2460;23:x07W456UdWqWOQ6qdNLEEzI9COEWQ73H9jq1FWP?=
 =?us-ascii?Q?q1pwDzKW6ZtXCatZMjkHx40o9Z1mmgdr369Ao+aqHn2PlUhh5t9Kb4LyOShQ?=
 =?us-ascii?Q?fRLUsX2cZAqA2GgmAG8TT6VfrJF71eqQot6toxvDG0ugVz9OTMVlx069gapg?=
 =?us-ascii?Q?SpmFs44tP2c7r4cJFj1MBlMBxpYwk4hGXGFgG16fKq55jCQrdcHPC4zLTNPt?=
 =?us-ascii?Q?efoAImyzoVPkK36g/PDfsbarpq/7dt5nhLthQC9mOFOovqEcLx1mpiV6xDwl?=
 =?us-ascii?Q?cpIt+IjArOWNDQl/Q4ux1sk8hs45n8CNNv/t8XtokVVXwHdfezHiKJAnQqeu?=
 =?us-ascii?Q?31biWIUxMjvwkKmpLXmrDSZJe7nr21u3AyuVufIEQjaH49QtOXxqZDUunQmn?=
 =?us-ascii?Q?N/lFCcsClB/SLCeqzCifcISx8uvQqlPSFSQKfO9TXWcmfPu7bDsvBQVAY0DH?=
 =?us-ascii?Q?dgqIFufVspH5gCIfsM/Yu/gUgeBjXnLheluxMY3Qr2KlKdFmcav+pu7Ehv4C?=
 =?us-ascii?Q?eKwXNQoWjOqQDlUqcTAb5e2Jr+eqkop2GJbJHymJBlZvssrHFrhLkejmoZSy?=
 =?us-ascii?Q?4d/J91NhNLZp0oJxU4uKUQPF4SzCqfL3pCSDnTx2zNeMfOXWMCYYW/9MMCDz?=
 =?us-ascii?Q?rzOX87KWs3Auj+P/aaO75vG+mfbMI3t+Txy33JibFyO9Yh08Cr5D2EHQRt/s?=
 =?us-ascii?Q?GO2S06kDii7Bw19LM/yTwSVNiG0wHr5JE+UoscALM18jmjGQ/H7qLWtvr6NR?=
 =?us-ascii?Q?mnlcUTukmoaHH3rQvPg/YS7W0BNWNHrOyJHuh912lJIJ6hjUyYn5mEhEDM+Z?=
 =?us-ascii?Q?mPifY2+hFIjFyogPr7rZOrek17O5EOENAVH9F1TAOheX1fa0cwdQ3AFpOcaS?=
 =?us-ascii?Q?ElddAoge4mAgeASEe8vDbWKhY+F2C+3NamPgEu6wwV1KZIEYBqL9/Mvsp75P?=
 =?us-ascii?Q?S9dwk0YicvGbGk4VvOdnOVdgcGUhj1u2C1gtO0z+e9d9ViSL22ZTJbcEYaZc?=
 =?us-ascii?Q?Pqw+78RAW+kkkDsJZYIuiYTr/hUlWwz1r51Jc3AsTKIQOOYawfjUPP55/tyR?=
 =?us-ascii?Q?mbNj7HNuStVLIP03kUSX5IIgI06WKWwfLgbxD8NHBlvnMPLURaVQVts6JkFb?=
 =?us-ascii?Q?MMww2R+3/nWhYYbmC6D9CbX5JFu3uYQFT7IUxApvKwdPOINBcwutjgt6q5XO?=
 =?us-ascii?Q?4ilQAaAMnlCVws0qf3S6y+dLc0fYgFuMIZ4SY725H0jbxp3OskDmAIslzzhm?=
 =?us-ascii?Q?E1O93qvTFD4OHbAJv819bwKBDliFBpsTwZlin4DE67IX5JDF0XVzWNqo7qNo?=
 =?us-ascii?Q?Z8DXyGyLAUtcZa51X6J2tRZ5BsxW+NwkpcvVnUfJzNv9QTi7Tyiqws4ktYMo?=
 =?us-ascii?Q?JYhFGW6xwy7+cSORWYYm3+W4LHP1bSl8s1PgcIMUAws2OsEo/OmWirYwreK3?=
 =?us-ascii?Q?k//5q8t+GtqzpSqJtBCoX5yAPOXNnvc5rc2SUcPa/RANHCHVvEZGduHZxgAb?=
 =?us-ascii?Q?TZ245+SuLRinziA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Ttn3KjGBgTCh71pcxI2rdk+O/24mzVhT5oovFWx9iiq1tBUcOk4PqKxejDpuabE47+3hmkCzFlo7Na/ZzhZsaifrQjZuDneO5wdwiPyhppNb9WwvuQx9JQsDZBlELJttl0GoN/deU74gO1AUSv1ofzyPKN8Q8tVuP3FEOQ9PIR3uIDcrxiEjmvbi3BNRZQiV
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;6:nU2MruN+BV2UOy+NQPJw1/Tm3e86BP56lcjCT7Qu/6Lx5hM8l+D6aPQHC1SzNBrF2i+cSrlji44gnoUcsNVPJHSPRDVXAt/r9/eORywRXMsA/mY9AE3m4zoiF1NpVyy0/QV+7QF777HH0Jr/5lx+jIBSWKFnsPbtYpRV12OyOaMCYH9kV7pDWHLOcj/j0hU86JxnUOsoP6LY72sVV4FzGSv0I0jfnFFsbHwDZw+snwwKcY2uKJsOJcRmG9fPJEJiVEZ0SAEPtNn+lzTjARvIWLUojU+ndNS4mFCOWE1RtRyc5J96yWRXTmyAVu+cn/xcteJb4EAPlOlG6q+b1DQtog61ewE++OIGnyRPy7PqZOM/qnUK1w/iDmtsRAX3q8dSje8tqwqq7FomgRh7VuSJ9U/6SrWNl91PFbufhKChVWDQd5xJJL1EldseWJseY1NSi5e/2cSpbTW+EN9oAy2LZQ==;5:SAdwU28qz6A/nT7rSc1iGvBfvr4ACQ++uMeJjvqij27+88Q6BMKBkWB3g73j76odyu072DpVWnzsWli59IMXxKWU5IL3NiNH8v2/2NeZbqKoC0wB9t3Ajachsk3LT9oJa8LXYS76DUSqwGChJnpM20XZvIMANEJxwpbG5M57oTc=;24:YE8lzNm54DoiLFVNf5OPqUGhrWX8+b8HtU8fTA+rae0C/7vtn1j+Sn0877axMeMaGzrnXLTGGK964Fyx2RLLYZ4hNAGwvhMo0R+RtL+1UJk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2460;7:+uEE1PNeHU2soWFko9+xUYPU4933BcaYerVHQJXn2xHvl1a5z2k4ZR8k3Or/4Aw9B363k+sq4+nxEpbNhYN8QQcUKWWOsd1Ke/FIVuuMX16S6oTRIFLwoGrQQhCz9pdkA2iKdBwHS6yXacnycFpzcbdXz3oKglYpuc9KWjMWCH+rq4TGMEHeB/RB1Cuqt6jfCArcIzwGVKMqLKCzL+iRU888U6zaaS+YevWyxhnegHlcgXrVtKIixW/diDqvaE0s
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 10:16:09.1877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78058383-b365-4c8c-7224-08d5d2a90405
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c_lock_adapter name is ambiguous since it is unclear if it
refers to the root adapter or the adapter you name in the argument.
The natural interpretation is the adapter you name in the argument,
but there are historical reasons for that not being the case; it
in fact locks the root adapter. Rename the function to indicate
what is really going on. Also rename i2c_unlock_adapter, of course.

This patch was generated with

  grep -rlI --exclude-dir=.git 'i2c_\(un\)\?lock_adapter' \
    | xargs sed -i 's/i2c_\(un\)\?lock_adapter/i2c_\1lock_root/g'

followed by some minor white-space touch-up.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-brcmstb.c   |  8 ++++----
 drivers/i2c/busses/i2c-davinci.c   |  4 ++--
 drivers/i2c/busses/i2c-gpio.c      | 12 ++++++------
 drivers/i2c/busses/i2c-s3c2410.c   |  4 ++--
 drivers/i2c/busses/i2c-sprd.c      |  8 ++++----
 drivers/i2c/busses/i2c-tegra.c     |  8 ++++----
 drivers/i2c/i2c-core-slave.c       |  8 ++++----
 drivers/iio/temperature/mlx90614.c |  4 ++--
 include/linux/i2c.h                |  4 ++--
 9 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
index 78792b4d6437..c42e14d4a127 100644
--- a/drivers/i2c/busses/i2c-brcmstb.c
+++ b/drivers/i2c/busses/i2c-brcmstb.c
@@ -689,9 +689,9 @@ static int brcmstb_i2c_suspend(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_adapter(&i2c_dev->adapter);
+	i2c_lock_root(&i2c_dev->adapter);
 	i2c_dev->is_suspended = true;
-	i2c_unlock_adapter(&i2c_dev->adapter);
+	i2c_unlock_root(&i2c_dev->adapter);
 
 	return 0;
 }
@@ -700,10 +700,10 @@ static int brcmstb_i2c_resume(struct device *dev)
 {
 	struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_adapter(&i2c_dev->adapter);
+	i2c_lock_root(&i2c_dev->adapter);
 	brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
 	i2c_dev->is_suspended = false;
-	i2c_unlock_adapter(&i2c_dev->adapter);
+	i2c_unlock_root(&i2c_dev->adapter);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 75d6ab177055..9139d8da29ae 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -714,14 +714,14 @@ static int i2c_davinci_cpufreq_transition(struct notifier_block *nb,
 
 	dev = container_of(nb, struct davinci_i2c_dev, freq_transition);
 
-	i2c_lock_adapter(&dev->adapter);
+	i2c_lock_root(&dev->adapter);
 	if (val == CPUFREQ_PRECHANGE) {
 		davinci_i2c_reset_ctrl(dev, 0);
 	} else if (val == CPUFREQ_POSTCHANGE) {
 		i2c_davinci_calc_clk_dividers(dev);
 		davinci_i2c_reset_ctrl(dev, 1);
 	}
-	i2c_unlock_adapter(&dev->adapter);
+	i2c_unlock_root(&dev->adapter);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 58abb3eced58..6983968735ca 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -82,18 +82,18 @@ static int fops_##wire##_get(void *data, u64 *val)	\
 {							\
 	struct i2c_gpio_private_data *priv = data;	\
 							\
-	i2c_lock_adapter(&priv->adap);			\
+	i2c_lock_root(&priv->adap);			\
 	*val = get##wire(&priv->bit_data);		\
-	i2c_unlock_adapter(&priv->adap);		\
+	i2c_unlock_root(&priv->adap);			\
 	return 0;					\
 }							\
 static int fops_##wire##_set(void *data, u64 val)	\
 {							\
 	struct i2c_gpio_private_data *priv = data;	\
 							\
-	i2c_lock_adapter(&priv->adap);			\
+	i2c_lock_root(&priv->adap);			\
 	set##wire(&priv->bit_data, val);		\
-	i2c_unlock_adapter(&priv->adap);		\
+	i2c_unlock_root(&priv->adap);			\
 	return 0;					\
 }							\
 DEFINE_DEBUGFS_ATTRIBUTE(fops_##wire, fops_##wire##_get, fops_##wire##_set, "%llu\n")
@@ -113,7 +113,7 @@ static int fops_incomplete_transfer_set(void *data, u64 addr)
 	/* ADDR (7 bit) + RD (1 bit) + SDA hi (1 bit) */
 	pattern = (addr << 2) | 3;
 
-	i2c_lock_adapter(&priv->adap);
+	i2c_lock_root(&priv->adap);
 
 	/* START condition */
 	setsda(bit_data, 0);
@@ -129,7 +129,7 @@ static int fops_incomplete_transfer_set(void *data, u64 addr)
 		udelay(bit_data->udelay);
 	}
 
-	i2c_unlock_adapter(&priv->adap);
+	i2c_unlock_root(&priv->adap);
 
 	return 0;
 }
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5d97510ee48b..6e8f8d2e847c 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -921,9 +921,9 @@ static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
 
 	if ((val == CPUFREQ_POSTCHANGE && delta_f < 0) ||
 	    (val == CPUFREQ_PRECHANGE && delta_f > 0)) {
-		i2c_lock_adapter(&i2c->adap);
+		i2c_lock_root(&i2c->adap);
 		ret = s3c24xx_i2c_clockrate(i2c, &got);
-		i2c_unlock_adapter(&i2c->adap);
+		i2c_unlock_root(&i2c->adap);
 
 		if (ret < 0)
 			dev_err(i2c->dev, "cannot find frequency (%d)\n", ret);
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 4053259bccb8..58a4a263984f 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -590,9 +590,9 @@ static int __maybe_unused sprd_i2c_suspend_noirq(struct device *pdev)
 {
 	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
 
-	i2c_lock_adapter(&i2c_dev->adap);
+	i2c_lock_root(&i2c_dev->adap);
 	i2c_dev->is_suspended = true;
-	i2c_unlock_adapter(&i2c_dev->adap);
+	i2c_unlock_root(&i2c_dev->adap);
 
 	return pm_runtime_force_suspend(pdev);
 }
@@ -601,9 +601,9 @@ static int __maybe_unused sprd_i2c_resume_noirq(struct device *pdev)
 {
 	struct sprd_i2c *i2c_dev = dev_get_drvdata(pdev);
 
-	i2c_lock_adapter(&i2c_dev->adap);
+	i2c_lock_root(&i2c_dev->adap);
 	i2c_dev->is_suspended = false;
-	i2c_unlock_adapter(&i2c_dev->adap);
+	i2c_unlock_root(&i2c_dev->adap);
 
 	return pm_runtime_force_resume(pdev);
 }
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 60292d243e24..1f2ed0dfbbaf 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1055,9 +1055,9 @@ static int tegra_i2c_suspend(struct device *dev)
 {
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 
-	i2c_lock_adapter(&i2c_dev->adapter);
+	i2c_lock_root(&i2c_dev->adapter);
 	i2c_dev->is_suspended = true;
-	i2c_unlock_adapter(&i2c_dev->adapter);
+	i2c_unlock_root(&i2c_dev->adapter);
 
 	return 0;
 }
@@ -1067,13 +1067,13 @@ static int tegra_i2c_resume(struct device *dev)
 	struct tegra_i2c_dev *i2c_dev = dev_get_drvdata(dev);
 	int ret;
 
-	i2c_lock_adapter(&i2c_dev->adapter);
+	i2c_lock_root(&i2c_dev->adapter);
 
 	ret = tegra_i2c_init(i2c_dev);
 	if (!ret)
 		i2c_dev->is_suspended = false;
 
-	i2c_unlock_adapter(&i2c_dev->adapter);
+	i2c_unlock_root(&i2c_dev->adapter);
 
 	return ret;
 }
diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 4a78c65e9971..fd68678f31c2 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -47,9 +47,9 @@ int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb)
 
 	client->slave_cb = slave_cb;
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_root(client->adapter);
 	ret = client->adapter->algo->reg_slave(client);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_root(client->adapter);
 
 	if (ret) {
 		client->slave_cb = NULL;
@@ -69,9 +69,9 @@ int i2c_slave_unregister(struct i2c_client *client)
 		return -EOPNOTSUPP;
 	}
 
-	i2c_lock_adapter(client->adapter);
+	i2c_lock_root(client->adapter);
 	ret = client->adapter->algo->unreg_slave(client);
-	i2c_unlock_adapter(client->adapter);
+	i2c_unlock_root(client->adapter);
 
 	if (ret == 0)
 		client->slave_cb = NULL;
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index d619e8634a00..15e7b2c3e7d7 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -433,11 +433,11 @@ static int mlx90614_wakeup(struct mlx90614_data *data)
 
 	dev_dbg(&data->client->dev, "Requesting wake-up");
 
-	i2c_lock_adapter(data->client->adapter);
+	i2c_lock_root(data->client->adapter);
 	gpiod_direction_output(data->wakeup_gpio, 0);
 	msleep(MLX90614_TIMING_WAKEUP);
 	gpiod_direction_input(data->wakeup_gpio);
-	i2c_unlock_adapter(data->client->adapter);
+	i2c_unlock_root(data->client->adapter);
 
 	data->ready_timestamp = jiffies +
 			msecs_to_jiffies(MLX90614_TIMING_STARTUP);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index c9080d49e988..40db4b0accb8 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -757,13 +757,13 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 }
 
 static inline void
-i2c_lock_adapter(struct i2c_adapter *adapter)
+i2c_lock_root(struct i2c_adapter *adapter)
 {
 	i2c_lock_bus(adapter, I2C_LOCK_ROOT_ADAPTER);
 }
 
 static inline void
-i2c_unlock_adapter(struct i2c_adapter *adapter)
+i2c_unlock_root(struct i2c_adapter *adapter)
 {
 	i2c_unlock_bus(adapter, I2C_LOCK_ROOT_ADAPTER);
 }
-- 
2.11.0

