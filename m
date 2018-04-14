Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeDNUxn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:53:43 -0400
Received: from mail-by2nam01on0080.outbound.protection.outlook.com ([104.47.34.80]:3978
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751684AbeDNUxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:53:41 -0400
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=fail action=none header.from=cadence.com;
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
From: Rafal Ozieblo <rafalo@cadence.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Rafal Ozieblo <rafalo@cadence.com>
Subject: [PATCH 0/3] Receive Side Coalescing for macb driver
Date: Sat, 14 Apr 2018 21:53:07 +0100
Message-ID: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(396003)(39850400004)(2980300002)(189003)(199004)(36092001)(105596002)(36756003)(110136005)(107886003)(186003)(4326008)(50466002)(48376002)(26005)(26826003)(2906002)(316002)(42186006)(16586007)(51416003)(87636003)(478600001)(50226002)(8936002)(86362001)(7636002)(356003)(2201001)(305945005)(246002)(486006)(106466001)(8676002)(5660300001)(47776003)(426003)(6666003)(2616005)(476003)(336012)(126002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB1809;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT016;1:vD7VnicjCW0AInUpqfqYHoZe4RV9XTH5K4UKSVzn28yYKlu5nXuT9gnzSJ5huz2k82Y9lziOMfPLF15lzKmOBlDhtgKZDCnv7E561vFeULlxTMyVDjIuux8tIokT5EUN
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BLUPR0701MB1809;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1809;3:h/ow2UVrYFVSkA2h93iMiX460QCtKJ/vcoJjyRiTksWtHmmlq29W8dQz42utbZDYIZoV9iJz+u+tDR4Iilv6bpdnd/7r1tLvORXDyl/mxkbUNJH0Qnygh+xciTZgLZqT6P/Z2shAqtjFVf9W2kLCgvLmLTXBPofrSEXCbw2NfBnvCY9SNfQ0mxWID5N7jvjkVRaOMJv2XNH1F8ab54xbtXxR8W2RjmvF068D0XmszK31RrLZqQgM2MIn0TG5xh1nAebeadmRNZGyhRk3PfS7Ns1Txq1bXfkwLTWSLbr6m5nytdAS41KrI2s95XqHMzxtgYQG46wqQqXI5z3U3drbKPGMwZ0KOiRE0wv0OMe3IJ4=;25:gOjTLW+YVWwzoxaGbMxB5oMBFBxTBPO3p/eEbt2G0uGgObsgxrPuyp6+Cib1/bOxoIX2rLb6CtjEuZU4edrb+IRiDm+/4Vw7MhjDlDuB8E8CF2hX0Dbq2Y+XDmK/zMGUsJwduqCfea+B5mloh4igaj6tzhv9RTkCgurh2JQ/btD9uXloJbLk77PIt3C6xe61wd9VyJ7IhCAixskro/zIgj++jVL+P8wdEJp3FuFyC4sLZHTHMC5Jn2pAU6r3wQAoC1Q/1qpPh34kTGk+S2Hy2x+gUpEnq3cqSse1Ie4cmOaLB3GX+cyRkkzn4eC/6SBi2zgdPdpHpsUGcFflMsUSLw==
X-MS-TrafficTypeDiagnostic: BLUPR0701MB1809:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1809;31:dwPri4I2KDgx18IkwVS8ki+aKOUfpG7oycgWXT6uMETkYAsFK05jwrUD0Uv1H+PiMpH+6DoUKu4Ae/2NTwkPHrt+kgy3fXasuyBBk8lyx8ODuo/tsGeKQmAH5x/RIlSDfHPfa1g/oAiqhMuM3SJz/6D5RsDi2gtucftWvLUJx0VI/nnGbBr/zNjRJyaiALCmQDz/LEvQjYWJ21siVmNf9BW9ekUNowG5uL9GxtRof3A=;20:9090f+jP/s1tYPrDMthIVmEqnYvfeorpYwywR3GXoaP44xXhnFW6z2e3Ny2OvrPYTnaigVTybsAzK3tTt7L/Iw6F393mHHMgS/COL5gEK6zdqUWZCZdGOwe5QauD4EbQR5tLY4C6Aldv93mb6xmnGr+gqWPQ1Fc0JnAqzFkL9qXyH9+l3dEGoZDaOPWHe9X40OTLeGsi1QRoh2ZLp5ey1XMeOBn37vxjcnpvlqmEXqpuUugi3zbA7UNuydL08qKq01+3Hm8xTwv8wnNubCEvnTDEkDi1HMLdHnv+9wtfdkpRNQPcvyUEzMMit2MbTbUDVQXsfi9Fm5tfbLMvoKMiU4CtdrrFoFmUFuCDdWKuiO4SHoqJaVdcE/J9sj3YQsRkbyoh/KxZnBAtONurjFfHO3Yk/tyq8X8CAmw7NmbjUl30Rl8g8Tn+T8UQnSNOZKzsNWYCeuJmUSzAocg5ha0YkkW07p9Hw/5D2gLOX+GPRVvqhMQ6N3u/jo3LKwoIZzYT
X-Microsoft-Antispam-PRVS: <BLUPR0701MB1809617445D7E5B5A9482088C9B20@BLUPR0701MB1809.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3002001)(3231232)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR0701MB1809;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB1809;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1809;4:JPVdG2T653GrLELRVCH30luHD1URGdKlbGyqA6FsLqyLmCR0Bk6VTxNvKELYDPz+SwhKrvkzDaFKo12B0BKbR6tz7xs8qvloJvwjP6mquB71K59c7882AtRk0KMpacGCj1cgqoQRgdFtcDqlHMDIuvaqhA3vYu1M4lRlEc+P73XPCIntam6YRthtA+amH1VR65H1fat0phqt8fq5zPTpFJkSlNPJ6rRPizYYmaP1WHbTUDSOCpv0IjLG7BHdhbmesMpzO4AyhPHdBq7Oc5481Q==
X-Forefront-PRVS: 0642A5E7BA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0701MB1809;23:lq1vaZDgI0BsYfREeLFoV7FS0lJS2hIfeug/6oP?=
 =?us-ascii?Q?OWQrbEVFOT5BEOlkxkEtmFBw2Ztswzv+7YUUd+nxipUY5oAkw6VsnIdTKjLo?=
 =?us-ascii?Q?kiavngkxxt53ALmp0xvr+0zUdX2+0BcH+GP+dtHdlOI8M1e9WTiqP4h64T/f?=
 =?us-ascii?Q?uC4C7J3TvPCyC64iVfYtppOhcP9YkJNNd+cvTo3h1PLRTu9XZX8+ws+P8K+4?=
 =?us-ascii?Q?D4LoKRGHteDEYangNuxt9eqeMPkOH83VRm1wzXnyVN4pJ59wypJRIzOXrLJE?=
 =?us-ascii?Q?BrRTwDtrmoCybXm1gIeGyrgZDjjvm/PuTsX0lW7ZD8PXMSWThB4K932QtK2U?=
 =?us-ascii?Q?nrzqt1nioHQDCE5hwkMFcTJN9B0ZqUPRu2VU4UHDcJyNucw7XIoL8WTUrNQQ?=
 =?us-ascii?Q?rf7bkbDOi+yepGhY8iVIMRdamW4mSJ5i47mNOVvyhLOlmqborVIp5xg2WXQN?=
 =?us-ascii?Q?LuBZZ5O1dYO1vs03MJj9LA945F+Ywjy5/SPtAFsrmbkAb0E8v324WX/5Ulb5?=
 =?us-ascii?Q?Ypc5fRkQuSnWn9aD14Fj2BvX+ELJv1ECr+i1bfVXNXdG+G7hyHSPf9YkrRyr?=
 =?us-ascii?Q?ESuFfgmTyR46N3MuaQG22UTJigAwq43CNZfh82QpauFftGkFeB+rBVVv4UCh?=
 =?us-ascii?Q?xncmH+d33BV578FjxJ0BNABIEaVmN7PjlTZ8huHGxrEQ6yUiHIEbZAopl0kQ?=
 =?us-ascii?Q?KCaX6rHdZ8P7+jWL5O1Ur0bdtq+Twrwcv7tSdnRyJ6Vur0AsuoKdGSmw/LCa?=
 =?us-ascii?Q?caXKfhaj1xjd5dDgpuz1NENbtmqanXjEXlkoeKF06snS7wrdZIzVmlxBHTea?=
 =?us-ascii?Q?HSfmWcldi6ZHLNROIQL0n6LS9gD03m8PfpJ4Tlu14OW8MnAMPWg4CU0jblxB?=
 =?us-ascii?Q?Z4K04M/GmBvGEKZJFLwGh50fSA4R/HbWKUUuJleTwq9M5dno0AudM0GhYszp?=
 =?us-ascii?Q?yhoxMFNK2TSkh+2FBZqs1Rb1jyg3K9jKWU8+ezvlZG74BiZOZx/MKz+sl6Jm?=
 =?us-ascii?Q?TqBE6BoteK/o7pUswq2WucVWUj0LoOxW0YBp3BKLkeGBWHLUgFCwN9yyBCem?=
 =?us-ascii?Q?+ziBDzKs=3D?=
X-Microsoft-Antispam-Message-Info: SZplllF+b2kxlytd0RMYRCdgjjZfp+NVI7zHltAeFH3UfbbSW3EQ3fd31peIuD6mZac1AfnHCW8ZXkIr4UNecrsTj1pwOEaPgY39QU+AB5lpaFr+14i6jWjROfM3LoyOHMQsliE2BXhkeHo3uZd1cMfHdaj6KY88vsG9pYsw46OI0sO9BtIW0Zze0ICasi7BU7O498lSZuWOVD5Sz8ldHghHuFyLorlLRmCqqI92WJcsvZYAkbKBtdUt/8s6TKZj1mbRcBn2AZUJA75sVyPEZHpLGCi1xA64HUJq2php4ZO8tMXMa34rXxTVaOx8SqQkKaw/lVJFyVGHzD0ORWJDg7dCaSmpxZdhfsshpz72BvJ2daNPQTWcMR9Q/QbRMagQSzET8NWkng+4aega5EdSRxJoArW3zKm6JBDGB/hxM8E=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1809;6:z9MAts/R+txnBt1PqxMLdlSD+NkisILpi63jtFgsloHZnSTsu+j7dLfR7RxByxkJqniNy2mn3czHpVg2w9y+WfugVjJRsOtMEljGiHZoUHycGniQ5/S1yQNxpgzpBrKOT//LinIgpDLbn2sInkqohbiYhHcSkau9Sbq4CoVRZmJpmlourgen1omWMzxjRySTcxRawGwJU5vWt61B0scxD8n47GJgFniXW62XsQSetAe9GkUcHBJbyIflAC3fF7b7FJZMNRfjUowmgxo57extLp7wOQSpZDoVgi9fth6ic++jz0Ah8zPpIWqP6xi9pO7HeBMjLGSHMjbEky3QpnA4QiT6RBZD4KOmqdXqN2DTf1PJZc4S6Mi3yL2K9EZHX5eegnNM/GOt6nYHdPdqcX7J9ih7a9/p3kapQcjPVKOG6IgtuSqpKaVHOtltVS+M5kQkDyfIC+ATnrkesIdodV7gSDUKxzzEGkXA6+zXsm47bWqq0ThekdHsmbt8RiU8ltH7;5:j5AHqVA+OIUlpfstpcUS9P+gcRyGPlvIde2sI3W4aPnjRCWDPqaUJND4P1CY+ByhcggNJybQ1lA2HF4a+jqIQKziTXMDxl+x3EIufQiEMBB/wyqV0+ukVlRvsQxebmGJQJfwza1kAWXh088zDAnFIr70cObeyerC/CRZ21jCpTo=;24:iGZChHvToyqLUNMjPtZglS9acfqX1FYV9ZMHz2f6cX4DRkwBYHGm/FkZo+I38zI9tH/2A+IkE27iCsQG8queR7FdFBQt4V+XRAiG9MfL+4E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0701MB1809;7:z1ekkDk0eXXyfWtwIOKGkeWypB+Cv0QF+v2IiIqLlWKFS2VJvFollw1ByBZXZYhJ39VfpeTqSmbiD9NrC6DU22ovdb1XMrrRgevpETRBEZ5y/+Bh/W0TFHgVegRWGkx5+bGexMJfEXf5sNfDrzlIHWbCpdv9z9pNUqjsZlFG7mOJ9bkth7o5r4ZAo9VlyMkI60l0aBM64Yl9TGhzloqeso/VtUCCRDIirDkXRTs6VcMBCYcgvAVLhrVGqS0adv7G;20:vrsP+CmwvvLsN7JRufdo82aL/abwHBAPNvkhVsTsNHIfdx394yd7dtD5f6bk1w9Osjno7q23WQGk+24Iy/o8Sr3fhhEe617P3lyVHOtdQRqAbBJZmWobyK3FCnTWOeDGTjhj7On7zAnX9P1uyrTz+Kf2sThhN6rCoKV36DutLhiDveeGCjAtF7WiehZRPZjlo7KugYWJjK4dm743Ep2odoqfka7lXG/IwsEvgEjo10OFAoGdrCZRD8IxGBptoS98
X-MS-Office365-Filtering-Correlation-Id: 6cb037fe-9976-460f-3b77-08d5a249cb1b
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2018 20:53:36.6039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb037fe-9976-460f-3b77-08d5a249cb1b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB1809
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for receive side coalescing
for Cadence GEM driver. Receive segmentation coalescing
is a mechanism to reduce CPU overhead. This is done by
coalescing received TCP message segments together into
a single large message. This means that when the message
is complete the CPU only has to process the single header
and act upon the one data payload.

Rafal Ozieblo (3):
  net: macb: Add support for rsc capable hardware
  net: macb: Add support for header data spliting
  net: macb: Receive Side Coalescing (RSC) feature added.

 drivers/net/ethernet/cadence/macb.h      |  21 +++
 drivers/net/ethernet/cadence/macb_main.c | 227 ++++++++++++++++++++++++++-----
 2 files changed, 212 insertions(+), 36 deletions(-)

-- 
2.4.5
