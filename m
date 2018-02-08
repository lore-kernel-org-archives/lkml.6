Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AH8x224022Gono9ECsZ7DI+PY48/ZEVBSGhHkdjbFOw7o5eYo9V4uiZ8Vgo6pPCyVqA1TE4Sjt+r
ARC-Seal: i=1; a=rsa-sha256; t=1518110234; cv=none;
        d=google.com; s=arc-20160816;
        b=Rc4XghDoyU1FbVlBGQy1hw0OS4qWWVHb+MNvkmiR28TvzayqvE7shbng4Gf7pW203K
         XCCTmxbOFW4fHZVip72B15v2TTcTRdVuweZrCMQOct9EZ5b9uu21d40A+dsJB/iIOwsF
         ibDdaUXOqkeMB5/IUVyCDLXb+6EKk03ixL000yUA2PTq8zEpxrcfmzkzJD61PjPfijHV
         hDj1Lh0qkKp6bjCxCOiN+bHfBFbENUcG1NCYqQRWSd1gl9CVb1eC3+CuT6DsKU4wX8jl
         Bo0i0ON31EFEXoPWkvC4G4bENk7PyO/jH8KgKEAiMM9WM4moCkCyz2Y2OeycH80wWDEk
         A2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=J/9zy/FJDaWvH07Lv6zWARj6fJ2HHmqdqG54XwAs/+k=;
        b=adIDVhr19y0GIRew5KEunQmJdnqdBcyyrd1N9sDzsCPtEnEV7vmal1JYbL1BcPpOF7
         HkkZeeGOJnuy+t7uTZb+qxSc+9wJZfVomFlDB+qvCAz7bmUm3k95uXe0jewQyuxOUFgj
         rAeX/E0K/dyuleD89W4HZKicXRKipjFxLg27iE2KHgJVa31frLyZjDqU7CY5vQBzvJID
         fkpd67Sw7EDZMhx7aMqrZPY7A9N8OTLZPG9W/8Grd1DK/5ew8bqhJwok2JDFzSMyKbOz
         sfMWnW4+BX8zyDF7QQxvXxZOVrAJWKCX60RXen8Qk+E8ecf9uSvJnfRH33n7LQQ48262
         g7qA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=DCmN+Rem;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.58 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=DCmN+Rem;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.58 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	laurentiu.tudor@nxp.com,
	bogdan.purcareata@nxp.com,
	nipun.gupta@nxp.com
Subject: [PATCH] staging: fsl-dpaa2/eth: Defer probing if no MC portal available
Date: Thu,  8 Feb 2018 11:16:54 -0600
Message-Id: <20180208171654.15511-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: MWHPR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:320:31::33) To DB6PR0402MB2695.eurprd04.prod.outlook.com
 (2603:10a6:4:94::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 339c9ae9-7a9b-4234-1744-08d56f17ca44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0402MB2695;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2695;3:UdOoHyXAw4qENUxtIeZLcTVi+H3cEpNshNXdqZYmj00Sy1Lc0K8Ym5oau2sRTHeVUSJJ38g0OOkTZelI9JnBmkVRLhlFUxJFdmu0dBVDOwfFVrGkNqR9b4/jv8HAXnie5QHRRHJhAgPt07AngnGG6M/LZ48r2LPgo5v0FxJeciPdQA5DviWNlLURXsP6Wy5lyfeB68WagLeLlkyuA/5V7dHXyiwB2Yqj8nHEIVxj5cV0bU6XRaNB0+4htxFF7Qbd;25:k2c0Coi04TO2wQvg2F2/tjVWXdtO5Cx1n8ayYOYaEoTeVQPoW4NAFqU87gPUnBz/BmwrkhgnfC5e5GwHQ2sefID78EwbCkBAwp9tnHHhL8DKG33A0BlviRnEJCWliNuhQ8FFf2xR9Exxf7/2e6kHKsGh5BZR80R34VjKmmKfzzFVChuY++P37ggURvCTG2f+2MxQeB+M09zkPyTTyOlYKhFJ5q0FmUhqOiEJ4vhFs+WqBkhiFjPa05pEU/+MSPS2R3jL+aq2RMZ+q5/h9rhpuLaEuuLxok0SGJ6zbotmqoXL3lds3i0rqw1w/2WgcHPtgy1fWOHZ3ho3kBzSKnh/aw==;31:AYQAiut5pOhqgAjWQVbKkxAb13NogrvqN8b8dV+RZQyRx8AFGURcBqnp9GMroIz6N2yXYuMSyaDeGf2yOA0Hmd0oGPZL0irT9L1J4A3DaLGA4/0m3w2ajmiBpOLeccLrOD6k+ejg/m8CA0ZTFZrKBPnVxfMTj7gcCjz17n7Pntu3MQQZkSy1hORQmbA3/khElZG1MS3kU0kEpUQ2WV9jN4l7urB5hxfaFFYzpzf0vuQ=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2695:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2695;20:CN6BvWDT978ob3FMvneHuOFja8VwKLXMDW3tpAqQtxhWQlLucSG6i/+Vk04/BVwh3QSBV6ATrKWBs3WtFZvhYbZQp3hiE2s5WN9CITi5YyPc2mhsF2flTrvD32Vmqz+zZD7CYpZ4/0MNXCMsu4d/dyvB1xnspDyzvQI91BjDJTIosd3zf8/+/YM9uyBvWPsbANQrMfwcHuMWaBsFRmqjBOCLjCKtSr+2hkS/2Gs9PzWTAfRSTs2HBVf8EZYGH2fMv0xeIGHESAXGz+bmFaR/hVD8neWr8r/2LPTbfF73RJX79735qlRPgH3tWG1nHMDUudj4pFpUiM37u7DQtmcnKi+WOgKTAnsl1T0iMB0EzY9cQsN/6kHOXnua+b44Giv6SFKfM4bFuQYnR9AHosYEFPvsB5gY8llLzw2vmuk/oKLQsZKxIw5Wwhv7BIgeUDz3iOJkxNGZDhBX5j41y9MJO94pMDZVYvwQTCYde5RXp3Dt9A/f8akpeBu8VTMSZfTP;4:p9cFu5ByWGvow7YXCt++y+1nArU4uHSka37ibhSFsZJSkYz629JcCxGz1z9TcrngLrRMloW5RnRopzOfiTUrKna/ewnLKcm5KwkcE5UkaoamrIJ6LCemSyMUMTE4xerM2DeSXIF0ff2w8mfIh3fOHy522Pq4F4OV7j+7wykUoRmOYzEXdn/qRz9vXjDnW32TCM3eBa4Is2JgZNWyj2vqEmfYVURscXte4X2XJdhR4560u6So06C9pAARKt7+1jkYFRpTos5y7aEtRUEo7N7GDn41i6uLU0xnNa4q6W4BK08po+WzHpuObigW6chf3PPfqI8WduwLZ3CjVgsIm2LGNVqemJ627qBG1rdrXamfnnTFMi2aRj9K3SIWymlPBE9/
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2695AD43C175F44F964C5A5894F30@DB6PR0402MB2695.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(227817650892897)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0402MB2695;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2695;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(1076002)(6116002)(68736007)(4326008)(6486002)(8936002)(7736002)(25786009)(305945005)(3846002)(36756003)(50466002)(8676002)(47776003)(48376002)(105586002)(81166006)(81156014)(316002)(478600001)(1857600001)(86362001)(16586007)(2906002)(5660300001)(6916009)(97736004)(59450400001)(51416003)(52116002)(53936002)(50226002)(6512007)(6506007)(106356001)(16526019)(2361001)(66066001)(2351001)(6666003)(186003)(386003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2695;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0402MB2695;23:H6HpFof1/6dHmKCpJskYeB7gA+ZwozJvULJx9RC?=
 =?us-ascii?Q?fhbfFRP3XjjxDPsBGDHxN9NxQWISOVSQLiUJfj2F1Iu7FuFWyAGZ4K/JwTii?=
 =?us-ascii?Q?y2hP/eUPCQfRy+i0E4En9TshYR71/6F0kb0M7OgXvBw+avKZ5Iauy1XbgEi9?=
 =?us-ascii?Q?7qe7YjYxZkyZAv9T4QyLVtyJOtjp/XWalUMl/tg+qwH/E3AcSPhMUAB+NBCs?=
 =?us-ascii?Q?4dJeHTAHtnLbihLXB2dtaPX9VGQQIoZGF3kf+k9p6TvGxgvjxZm3tNwytbQ2?=
 =?us-ascii?Q?eS/zZvTpvvMuNTbSYwmaLsVE2W6IIhb4b4EGj3z/A3oVXk5hS88L9UlplOv+?=
 =?us-ascii?Q?h9U2cIHH43MZpq65HU6t0fmKLPdKi91oqEhN278fYOKeqJKpxxy1Kk0PlbjW?=
 =?us-ascii?Q?75xJpaAFKi8iz6Cnopcz2jCB9XVQYMRFXimF45mtxeta2clkZD5KzAUVkiZN?=
 =?us-ascii?Q?8NW998kEFv+DBuMju0t8BPkJ2VDzeH1C8U/WZubJmoSVy5Q7kSXl7nSrhGSV?=
 =?us-ascii?Q?3b6Qo83fs/oIXR2ZjLosufb1sgBW1fzM5S//IwdXTt89/kYsy6Vo0KGyvupH?=
 =?us-ascii?Q?obhP3RLRqou9ymOac8BP8gvjZy+JiHtwCPdgxvLl2H8H3mIdNzKI2CDVaKuR?=
 =?us-ascii?Q?QaJYXQVN9v+LzhKhQPexlg4n4xMFEZUZkraA9dnP6UGh1uZtlsWfsvQULDjL?=
 =?us-ascii?Q?1WKQEFCv3Pq0yyqtSzkYVQfHBC+Ev/bFacxNCqoqw8mbo9ee10JPCx30qfbL?=
 =?us-ascii?Q?ku+0AAf4CHJhlf/LjDKnP8ZCEqnkpJbnKpAQHMSxsK+UtmdtpW6Y07Wm9VCB?=
 =?us-ascii?Q?0PRllxdAyC1g6hqvPSo6s6a1wX7a/16JbriwFmc3jMncbnwXk2stZ4PeW9Im?=
 =?us-ascii?Q?M/uAOb3yB4g1WfKlrWhAVVMjxjrorzFd0oj9jxsl7N3Qjk2sf7K7qOx27427?=
 =?us-ascii?Q?v+hOhTW98jK87qfHTKlxXqT6VJYRPDNxROsLNzV/UPIqcfgIFmnlEsJ6Tqs4?=
 =?us-ascii?Q?cs0WJW2HW9V4m+AzClnrtlmS+x0bksAckZL0B7RE2HG6Gk++o3GoGrNC6DS7?=
 =?us-ascii?Q?jMMD1Ne24z8PriRRxyeEI41FvpIuV9eIgKF+X0nlAl/G9ndLFaNie4eG4J+5?=
 =?us-ascii?Q?KNaqmABih/00DpjjVVM3ouGXJR5XWgacH6ZkTkqKshFnv1dX98xcyzg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0402MB2695;6:3bXXEcgFEn8ZRnBETbWw77SPwd6De3LCCbGeeLhcnhMET1jthAwv2eld3us7/3M9kU2VZ9gLSkrDumvoKmvpTJwITDDyr+9vuLl6iX59COXbpu/B93+SzNHr+Odi6LhPnB/f39ONRjXgdxGwz+gx7TAxjFIz+H133PYZMKOSuDLlPDPHJthryoDEe12JmjS9EWU3eW+UmEvZVvr0h+6dyxokljGktnr8tOBfywYFxunXQIVVqoqAEHS0XjGAJLxLU+IdPL7ohfnDNHW85ZH36Otd8hsuVfk3mIpJhXl2VIlF7s7ZUk0Vi+qHcg7fMLrvxiNPDOvkv7WLHITrJleBCw2sMsyIY892+M753zTX0FI=;5:skHVEK5kSv4xvPTIMF4tKdDAayNy2wLHV2eLaTLCph0Y/6+BHzm1FFE+BUsx9P89c5yTplEIGgCzZejznXsISWOte5mYxcwoui7vLfDk6uWnT7+klioX7BpfCBZF+oiTBgFmcB2KCiS94dONcjP+CU81PDuLu61NstNSvBFo7hc=;24:ml35DxTkDXHng9ect6pfBvn2iRTQR89NmN5O6N76DtNWfOHv+dj77zGHdAQvbqFfS3sZf9GIEra2fnlFQ9tAiHJRXz9Jm5FpGlEbedLoCc4=;7:sravly5IwGJMhvsZvTLj3elIhZr6TAHwd0xH2H6dKau1qmotTwsx1Wn6ZrPVuJBMLQ/+CkOiJs552Op89AS+Ck6uXVcoioBuVBIhc/wz4TFBKTV2cKk1urF4do3VM6WmilMsMTTlN7C761nPlWYC3906A+q+CfHFpcIEsLBGkKe6UD5GtzRWHIzMkKIiGAs+NA1ww/NWRk9GvaE3wSupnjLqMj4EMMqyWgN9n3dzopTWZuySQWlpPJPqlqLPHvZI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 17:17:09.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339c9ae9-7a9b-4234-1744-08d56f17ca44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2695
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591853956941717936?=
X-GMAIL-MSGID: =?utf-8?q?1591853956941717936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

MC portals may not be available at the initial probing attempt
due to dependencies on other modules.

Check the return value of the MC portal allocation function and
defer probing in case it's not available yet. For all other error
cases the behaviour stays the same.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Suggested-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 2817e67..e4c2804 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2440,7 +2440,10 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	err = fsl_mc_portal_allocate(dpni_dev, FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
 				     &priv->mc_io);
 	if (err) {
-		dev_err(dev, "MC portal allocation failed\n");
+		if (err == -ENXIO)
+			err = -EPROBE_DEFER;
+		else
+			dev_err(dev, "MC portal allocation failed\n");
 		goto err_portal_alloc;
 	}
 
-- 
2.7.4
