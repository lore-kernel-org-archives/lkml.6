Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx49X4FM5t8vMOZ7rjDZWsAG9oLq8g3d4iEvzqn3TvdkqojXVqp5mqWYcezQ/bPV8yB+EUTMw
ARC-Seal: i=1; a=rsa-sha256; t=1523450867; cv=none;
        d=google.com; s=arc-20160816;
        b=JF5O6ayZuDnmXMq1OtvEgFzO+fEffChWnrkhTEEFFTV2uH255grGETss0pRBL3SEsP
         W+lnpJRiehd8Xj6Gd/oFGMfj+6EhiGsnZxpF0eFN0GLjHvnS+Yo4t+VTdWPtmIeS3Mw5
         r+wfXA+q9UriNDloUFz24nfVvQssCYylEdEKHc/Ea2LxL3kYjffPg3fOft0h+q+rAwB9
         aRAi5SEHxTmQARlzgql/vqIgf0QjcCTecS8JoDJbA2iKudnXvRsmtO3vXGi9GogfjAJ7
         l9Jri/BMCopU4FWbL8XKkdY4gXOpiI1kj8z6L4tTPoehkS5RV3jvqehHq2ISlW3a85jI
         7CFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eU8pti08FsR1FhAryo23rYf0YtE3RhXM7U84cf20n0Q=;
        b=U51+lXkhat2YTW5LT9aCO4AIIL8PPBBXrorH/OFJ3x/tVrgj0VjpIXjJ/kFiH61Hwz
         GEqk4WNhAoQSrp4FdpVFfm8m3NQLE/bR0X6JTPsDAdBEZrTyK8qi07MfS0whqv+wr1dz
         uu9x6ljZyab1bvFsC3MAXKKwpvTWdJ2f5H0aDI3kndeMbnosoFS4rIRRmhFyWfHRFyjf
         gEbaDnytLHL1UMowkaS12D2BzkabC1SySvZxIIMZ8TKP33nc2zb6xUexzTwWYKnalRJx
         luGte4GuqbSDlbqcKUiWquxv3/95whJHpanIkMG+ZYHHcbNKIDcxTwfUO3G7Lf7hCQv/
         nddA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=IgI0MqWC;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.0.110 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=IgI0MqWC;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.0.110 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Rosin <peda@axentia.se>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mux: adg792a: switch to using .probe_new
Date: Wed, 11 Apr 2018 14:47:36 +0200
Message-Id: <20180411124736.9515-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::20) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:21Uan4url7Jf6D9dyRVz0DFnIOWwAXY2BLCV3pQMPM2V4Ph8eUZgGaZUytdB8gPlf86EDocjXuK5BoYc3Jwp80V77ETGTfAJ7AgnhtyIEVVze0xATESp4fOWialXm4Wktd1Kxhf7olMR6199x7DlOVXXWGV6oD8oZoLr+9jXtd/P6CpQN2oslXtJzFYl8VetLDnPYwNOf8DyuXPtu1ywGwRHrJeHJx81v/TyHu91klL6PNH2klgaM8m5Tng2FWvD;25:wjyl9TiTlAP9Gw6L+d/8dNyAu4loSABQFp5JFzD6paN+7gKpgRGjH2TAgAK3DGs3XCEIzW1TNpbDBlImuHkNi87zjC2uArTGl0lpgxzU4fGdBLtC/CswRoaLEL/Rpb16nxLjB1sHgBU+9nWYcVLIBwesIm3XQHw9E7O7I4vMACvkjLkHM0T5POqySEO8vOCh7txC9S6GRHB70iE7RB6XJeGqjqJqPe6QK/BCij+awfb//EpW6n5fqSl28C159LUp0mIJmNDxggKHch+7TnthsKOFmYQJnubTSDtI7HFxt4++TVpNpWgbxE/ajrrkATVOU8mKb1eFA0W6f4pwgq/vCg==;31:s+fUpx3VfyRoc/coJ0FTS0UsFVVPsWsDfO6lqZzK9Ys/q8sNlAr98lVHIqr4A6y9oFCjoEKn6b8ijNuOKMMJohHeEo7wJzraelriQQpN7ht+itsHdv5+TenJbLclai+blVCZjRQ6i9ZQ7ULdlPVYBPVDKJUoZlceEUkHHXLcJVwqtk5mQq7NZSr+ozjb/0VEt35UIY4PLmTAVT4rIoenVrclc6s9blIRDMEBbdPpN/I=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27693729501155B873234600BCBD0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:omq8OoaGMje2l1wlMuJamuRDMDe2Q9rAjqsIgHl/DaMWJUQGKlUYd30hADdA2r/Eeo85aV3QnOs7DJ5jYpnAHDauHau1yrcstIUy0jm4eaomlBA/C14KB6onvnkNEcN9yk3cOEm08X0raqCit4E+XxBVGDRrxtbBn206pbYaTTg5aAg4zeEkz4Z/k16yeBwlKBACwt6VyJHlBCCxrI4tFv1CI2Yhdpmbtf6Zori2WFPpmprbpJexhdbCm4czb1bmUaa952B70pSMKlu/1JXxAg==
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(366004)(376002)(396003)(39830400003)(199004)(189003)(6506007)(486006)(81166006)(68736007)(2906002)(8936002)(86362001)(1076002)(6512007)(386003)(81156014)(106356001)(16526019)(186003)(26005)(478600001)(5660300001)(53936002)(105586002)(36756003)(47776003)(16586007)(51416003)(1857600001)(7736002)(97736004)(6116002)(6666003)(6916009)(305945005)(3846002)(476003)(6486002)(48376002)(50466002)(25786009)(52116002)(956004)(2616005)(50226002)(8676002)(316002)(74482002)(66066001)(4326008)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2769;23:FUUkNw0PYdIUGcjRvU28S/6Oc363zrlq4ilrgBA?=
 =?us-ascii?Q?Xc4FlqOX0GTROaSSMMn6t8JyYcsR3cTTscu1XU36pEbNHWc0mwe56u503io+?=
 =?us-ascii?Q?UiarjK3POHyS5ZJJ8vNkbIyunWrYAKfP3/fBR5pDAM0QWTTZ0zm6gt+xTPh+?=
 =?us-ascii?Q?T433p9EcZTZM2LeZxA6shpqJQEm9EpgzSuERcydDD8dyoBeBfQy5uQ2FVoUY?=
 =?us-ascii?Q?RCxbd5IvpqwobzTg6vPCjT/kXd1PpNhutDEo/H9Go1sdLMiXt9mF/gk/ClG0?=
 =?us-ascii?Q?RIyMc9ihP7ohFRPtyeZZoE7xI2U6WMtD5ozaZJ7nVzvHCez0ystWfl3hUr9d?=
 =?us-ascii?Q?iU9BbdlxcYcW/Bg2hI7ychs2JZ9TuGoCxkc54Ad85jNmr7BcmIoAcM1cwwA4?=
 =?us-ascii?Q?8pvWwiMMlxF07x88431pJuhbqCYwC1oVP+4jvTtX/829t0qz/1B71q0z4quL?=
 =?us-ascii?Q?jd4Tnv3iR88cBtH9B1D5J77GYULqvS5vmOjOM0fSYAn7tlZdzT/T8tTcqtED?=
 =?us-ascii?Q?xqy3AUVjEp8IUwo9tk9Nj1R/hCCjmIqRHVCvPZigfe4nXdFQXLfhniRjRVTQ?=
 =?us-ascii?Q?ByJeU/3/8A54N8Mrsh/kGL1qZNzASsUKBa38GBXuyZtyIEVxkpmi+Gv49PRw?=
 =?us-ascii?Q?F0Fm6eBlFSCASurJU1LTPijbTXfS3uA8bdG30GfiiTEdOHFoutiyWnXTaLQQ?=
 =?us-ascii?Q?q1XdRlitNKCzDZJ1dXYBN9dafDu1Zg9QtOvtND+bS/4P9nJ8dagf/5nRM+VN?=
 =?us-ascii?Q?5+AT0e2lJ/2A3cri0eDvfX31UTxvzaQLHenruhohXaBiFevnydWVVrQXz+cF?=
 =?us-ascii?Q?jnOuOxiG5yI0PCBdO5MyeTQwYbGwfZt95LAniUJTbcja9iD60vgas6zJ0LLW?=
 =?us-ascii?Q?10wreOfXn5Qa7qLbnvQh8HRox1vNNLIQ5f3hzxkSDLCeqYmCms305R/IZ4Z1?=
 =?us-ascii?Q?1VlhSO+rHlfma6I6V4zkk0WahI4kM+UOPVsobH43xaFUIBe2Vz1cHzyAIfEc?=
 =?us-ascii?Q?k8pBxBNrIogF1kxYZncRq++Fx6BDGzZVlj7n3F/bX9WnSrDOwaEjE5hpjpVR?=
 =?us-ascii?Q?iDtH4LIF6vvtlEAFg+9cE2pLRzguAyv8szuu47Q448sJQH9tqZWlUX4Kmohh?=
 =?us-ascii?Q?xxue7xgsQq7GX1PTtXDmxZfEHYlCBrgQefEtU3O3O8GIJ7iXR7LyqcWVrxt8?=
 =?us-ascii?Q?UJRSn/QHedZt9NyxmK4ll/Wm0zpcQAInJEFhU94YeY9nXDoOa8/CTUfjgbQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: sG0aKyesPu4H9MXmfocth/ZFEkGA7OC9z0wSgbaGlZXfWSxYKCZ1aKQ4goLE5NB9+ANYtACO1A3R0T3UCV92xIeBD2M894qbppI4fQLeo6/y9nbWGM8MFXcXxQAa3YgDJyvbxLJf3pwFDQvlYFlCpyNG4ku4Hhjay6hff4aOEFzhYS9sK0p9fAZ+U+MRcdIU
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:periaoLG4ecFQ03Xl9dm0ZEwFXv/Oi9o2MtKJeukFKJJr6ALsJakfc/o709ynqHnU5st6lej1HJuhYo+qhxnanZdBQSo5SSkMzABg4ptz+AFLnqFt6jLpDAKbWPTPREaxje+hwWqFWxh9u+7zisvcGqVfliQPvEit6IwYynn/wMjEDiJ2dKGX4YrrInc4zqkE1C5XbsH7SkDuTzWhDimS3A0AOB/VDlWmMVTx7l4cz14TwHSEiKPjAvDY+JYipmb4NH+WGBB3hW2pN220p8JrKfDmZu+xrBzh+tFdCKYPYBsC7Y6ujZWA79hprWSuwDQsIkg1hPmXak+ayR8UnBjulGyhFVQ8yD23hTNCm0x6Mr7Z/HOONDiAbE/ndaPMciM/r/Q+BvX633Q/1FtCAommiJ6CwxxCIECoeQIaBvBCBC+AsMjVcummq8mXAdgqev3YJaKCDnEZkY4pgAkaXFtnw==;5:ZVT2Edn7yp9kY1wCTdDqGq4dDRlEtHEG53JFMStPBEUr0U7Q0Cg6OlM7Zx3A9G6AWJG8zSzZIHqScRXUZ+EfI278SiH1rQYy6JUy4q2hJ6Yvd+MkagBqGp1s78qhC4N1h7UtVin2lvHoIGoyDxlk9ahgqwgGga/sGT2UEixH5bA=;24:jaKTkNYbKnmBMymhSKPWTu7i/Tj6rmsCgGGzGeo1I+5Abcax6PzgK4ag/LHi0a9jumJuSl5jstdMKNNx6PPgAmXy2qmnRdAGfM3zYUhsZZs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:dJr6ctRdwqC9tZyih93Pk3F2YpjlHlzj2pYQ89RlylGs9UQF2r6Efyo6Ba2JohgmM8g7h5VzVPWQkKYixhy49OnwMFzo6DhRVrZCO8iXg3S00PaYQnVGyhXszszWUTsnWjZqavuioPytio2+fI8ie3xWIQAfur3lGiHgLGS+oLl6BMePSXPoGGPHtOtowWlc6Ntf25mrn2cS55bm7Aw8yAtZ/ErBJavsie8oWpMgjDgnXoauH2V/CWIxmJLtkX1v
X-MS-Office365-Filtering-Correlation-Id: acb4bee1-a7d5-4cf7-2e32-08d59faa6bdf
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 12:47:44.3216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb4bee1-a7d5-4cf7-2e32-08d59faa6bdf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597454016819901476?=
X-GMAIL-MSGID: =?utf-8?q?1597454016819901476?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use the new probe style for i2c drivers.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/adg792a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mux/adg792a.c b/drivers/mux/adg792a.c
index 6a8725cf3d71..e8fc2fc1ab09 100644
--- a/drivers/mux/adg792a.c
+++ b/drivers/mux/adg792a.c
@@ -58,8 +58,7 @@ static const struct mux_control_ops adg792a_ops = {
 	.set = adg792a_set,
 };
 
-static int adg792a_probe(struct i2c_client *i2c,
-			 const struct i2c_device_id *id)
+static int adg792a_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
 	struct mux_chip *mux_chip;
@@ -144,7 +143,7 @@ static struct i2c_driver adg792a_driver = {
 		.name		= "adg792a",
 		.of_match_table = of_match_ptr(adg792a_of_match),
 	},
-	.probe		= adg792a_probe,
+	.probe_new	= adg792a_probe,
 	.id_table	= adg792a_id,
 };
 module_i2c_driver(adg792a_driver);
-- 
2.11.0
