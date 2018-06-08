Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6u7ZElqSGlu5cAAAmS7hNA
	; Fri, 08 Jun 2018 14:28:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F2E8D60590; Fri,  8 Jun 2018 14:28:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gOMjH/m1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 61A84607A4;
	Fri,  8 Jun 2018 14:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61A84607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeFHO2F (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:28:05 -0400
Received: from mail-ve1eur01on0127.outbound.protection.outlook.com ([104.47.1.127]:3680
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751643AbeFHO1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6jwEoeeXVRb5/8YsABc1mpC2EIib8G4RMwSPpQdrIY=;
 b=gOMjH/m1cMetZOzQLpgiopaEap/LdzQ0xWMLq80ijGEgS1KZDLnJY8i5byKXj0rKxEav70vzZ9z+cJoeJlETGYaZf4lYuxw9/mjvrnsov3KxeDgbsJ0+5BMOONnMfz149hd1QwNhn7GU2FJFEo5Dm354s78NwwrcJL8XAu04Nq0=
Received: from finist_ce7.work (195.214.232.6) by
 VI1PR08MB3117.eurprd08.prod.outlook.com (2603:10a6:803:46::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Fri, 8 Jun 2018 14:27:33 +0000
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Kirill Gorkunov <kgorkunov@virtuozzo.com>,
        Andrey Vagin <avagin@virtuozzo.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Konstantin Khorenko <khorenko@virtuozzo.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs/lock: skip lock owner pid translation in case we are in init_pid_ns
Date: Fri,  8 Jun 2018 17:27:11 +0300
Message-Id: <20180608142712.32460-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180608142712.32460-1-khorenko@virtuozzo.com>
References: <20180608142712.32460-1-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0233.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::33) To VI1PR08MB3117.eurprd08.prod.outlook.com
 (2603:10a6:803:46::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3117;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;3:cXV1RH1ojEh1A8IhCQRi8vEEU+INV/n4B3qLJZ9Fd2DsBTLdLPUbcvaTkzmvRgz069kKD7ukgjvk6lVj2dqMIN4rbhHh+nfuy1PwNJq5fQ9gohkOcbeuXBlcgKTK2AQooxiXJwpi8pTQux/E2R5rjDZFFvZJJzIL9+jJTkT+snzc22i4nAbH+29kR4gZiyVL9a8ZvLmRjQq0fsktkjnCfGk9E3mhzQU0d5zPiyVUdnOnl0l/y6nArlKvUt1hiPpj;25:t+kVo36u49nrtWeAgrUJe+nJgjSYuSW9nx/ZKlB24XiErFqQzlhMigMsy14RFXIkEqfVIERffIAg9F57fLFiLtuYTGZPHfc3WLZOcXd0+ieoauZjDUgljnpBGMLkGAcEV0bmGbZlmbRD22kTfHS7/Yb7Fsr613O5BG4iuR5HAMxwFxcuuUQfe+peU5NJUlhvLRDXjx0orpv7oRIpk+p/CAX/0PqCXahVKkN/YoJww5EXgqkNINbXX47cUFGrdGTiqtubVf6XAygnMIM3UHCism+8nszpJJJEWuTxCn1C9T9n4O2tY3cu/uALWgUQIiXnp7MxnWce02F6fkKSaz92xg==;31:nlEzVec3zRO/WBT0a2EoCvbUhh6g1OJcKph7PRx30mFpNoQWaHmbCakKLLorS2s1BJc5CaSyheZTexQ98XXvO654KlRD4dAcbEw8iE9s1+gDp4dnh/LlTdzdXrsiOc6CXn6Lo1M+UieDcO2W/5r2y/9EFiRTaEgjY4jHcrQpX1TNRvlgVyEa+TcZC2EWMQMAxks5ToqFpyzIwX0ru3TfzsIHw0Txle8TAaYT/kHRR14=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3117:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=khorenko@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;20:B1xtQZoMKtP6t/usUgYBBFPaC78jcdx7OYi3OImt7/UPZa7Oxfmyb7Aw0XW6uR2ewUA6hWoL8mZ1H4op47cEXJmrHoukiQIWx3pFe12X1x5GSE6rHEu9un5wndU4YZERMOHMXRa96W6shKXekBm0SXqjUpbQ0v6AF71SovZgyFPx5deR8pZoaZuOMng2KfwP19Z6ZfaJOvwXQIKKCuzpO9LsdMg4TYlVlgwcD8xSHNebrHcZRw0JMqeuRQRBgPhT8hTo0RrZdyAHYHo8fW9cqA3/BG7d/H4AX01EM3doeJuJ8aX+Iwr+/TuVrUbCDE1V0n1pX0L03IfYgBiSyBad6leaMxqhYg/9HTshl1RNPnKzRQOOyEhu/0VThuceVnsMhLjfHjV1Ilts33MxKHK74+1a3fS08Ei6iqBLDP1Bfy5TBVtZYEdPBzCstmEn+yRUwweYGSGUiZ3xmgnMBzkI9JMd/+MgulnjOXiEUcNVVfvAHrpwa+oiQKSFBnPqDRnM;4:J3nyXnmssPLj8dlqpXBHisDbd2GM0iWSTeHqB3H2Lkz04CAIPa794/kKCbCdpaesXbjUbWwfCcpBMF0NUdV5jL7KfATbEz/hAQWsiHYCAYarDjsGpsaBOuqRhCMVAt3yWR4Gg83bx1TnfOmcFber7hTloHN+LPJ84xJ4C1+QLQ/sY6SxTTwSkFeJ6IGuVoDD7Rg8dAcne+DAS09EAe+9q5KSZU07Ebfasl5dGGuWepNHC0AeLd4PDaDBFmApFj2ljE6N6cK7fryR6DPlz4iOPw==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3117DE1DCD6841B4655AE0A4C87B0@VI1PR08MB3117.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3117;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3117;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(39850400004)(346002)(376002)(199004)(189003)(16526019)(52116002)(51416003)(3846002)(478600001)(1076002)(6116002)(69596002)(386003)(6506007)(66066001)(5660300001)(6512007)(25786009)(47776003)(36756003)(305945005)(8936002)(50226002)(956004)(76176011)(81156014)(8676002)(446003)(81166006)(59450400001)(476003)(48376002)(7736002)(2906002)(53936002)(11346002)(2616005)(68736007)(486006)(106356001)(86362001)(21086003)(6486002)(105586002)(50466002)(316002)(16586007)(26005)(4326008)(110136005)(54906003)(97736004)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3117;H:finist_ce7.work;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3117;23:4dUJZgGO+ALPr0+pYaJzGhd3ctf2mSpypuprpXnNp?=
 =?us-ascii?Q?eWPtV7YPTHxe8gsI2TGCGsszPCI0Z/80Mt3tTPEl2Gk5EIQj+wkt2svMowns?=
 =?us-ascii?Q?8eL0bgJUOJ6dvoIAFupX64ob/fLp9xyyXlXm84uRIz0FailGqfrqtZ4xT5np?=
 =?us-ascii?Q?vFFUJfjKlQRBMiFCo+Ai5+zIUN6lQ5HrrzEAfE+BVCQjuu/q7hc+mdHTDP4S?=
 =?us-ascii?Q?qGMRDj+n4AuG7Oibj7hGtsIMs+UEYmGnGcLz+gLe42fXaHmQGEH2oasHtp9+?=
 =?us-ascii?Q?kDdfQX8cBVSL4ZuSCZUH6zEDc6orUGbj2ZxV4srKyWlMK+c06zwNOGBQiGUa?=
 =?us-ascii?Q?SillsEdq+aqYYHF68nJNclx5hd/RtJYS9+6+bV3YNFELGWfj/f8BMxqXBZnX?=
 =?us-ascii?Q?PCEvuCPzpdpThboV1rczFoKFVAwVw2lMFiuwY0B6DVRDnaY41Q3JxJGOMfwD?=
 =?us-ascii?Q?FXvkEtFl1/ij9lwc0r0ks8y6VfqYgaVU8jsIw08jrg+GrG63/7xvRQtxqQDY?=
 =?us-ascii?Q?UfnGSPR02tDPQcFONr09nt2u74QsZLTk5kelmxYPKVWFPlVuBQnNSIsRYKNw?=
 =?us-ascii?Q?jr2d8nRtOCEmIhe/4zCmCZ2K64gtvJuf+Kkw3lXUliPDeNaO6rd+Vz1RkMHY?=
 =?us-ascii?Q?HBHI6x5KJB8rVSUCFY7FDkLQpKhYvdC7OEXjWfXrcVClqXe1YTztTMbHPW7S?=
 =?us-ascii?Q?8unGQAk66GwcyUdOAzhxhJuEr4P2UpzceLbZJ7WUcGe1sT0G9yl1xQPzSgal?=
 =?us-ascii?Q?FraHW6DALr+Gosd2/GOUpCUwbGgkdGFodCWdF5VehTaZuD0wi3b9XSPhoxDo?=
 =?us-ascii?Q?TqDUy2g8aH64Z9IyLol/+WOP1/1hzJTzPmIBHnVAUGbTIDgKcNSBnpVfsrf2?=
 =?us-ascii?Q?tpF5bZrBK+nTGirFnBR0YeEWAErIqSnHDikAzAGaBtb7wQlertOtMw7Epuog?=
 =?us-ascii?Q?5evdqa7oBzTs3fuPZkRVBGv8UNqEY4loSLkqX9EmnSFNeBK7NywmgvUv5TFr?=
 =?us-ascii?Q?Q2SHebsETutYAdedfcrn0qDFLzxDToRJIJ6E+yZIjkqYpziyag6DInJ0nFxW?=
 =?us-ascii?Q?mGZqM/OOA9Ew6253oKm3nlUGMklAZD+REH9biXyNXzYhvE6P7XGHQ41aejBk?=
 =?us-ascii?Q?rpQcKmVjjMA0PlMaws3EysbYRtnuoDAsgPvUB6W55QezoznlSllCiWkZ/Qqn?=
 =?us-ascii?Q?mwnJTcIU/ydx7Lypuri80nFdGXifOEAu0X6tDqC5OUzrdqfpFz8b8pnZJ3Sr?=
 =?us-ascii?Q?yU+IwWzKtMUOJz/ieFLjjPgU+0y2G8deDg6JSqv?=
X-Microsoft-Antispam-Message-Info: S+VSQTA6d8zZ8FibC3kuDVLEZa+PeXgM2drm2cGAN0IHiT32o7vpPSiJe2VP2BmljC+mfrE/LPXwAXt9IJQNS3RfTFqYUej/B6BUHMgVV26D4QSm78wSFOL2GQbKg6ASQoYq+bvAAVuLyqeETkCia5Rhnq2g+6lza51t5cDqQLVmjAPStGvsYJ7MagnPmXCx
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;6:nZ+L4sKIeZ6fLxCDP2oc3QWPZ5GjdmEVa79JYmq7cRTeoIFZGIXRRbe790IsybvjIHWN5BQ5P30m03qgzeJoSNGHM8+dHhb8NEJktSNn5v12mt9cLs2FI1tEmb/WAB1SB9/EoUxx+ZkklE+l0LUmS2OtJBhV1zdh0uJAWi/xSp+d0wK3TulGsaO/Tf0DHibWpK3eP4M/nEiWL5doAn2ZUVfffe/VFd3VvP83J6gMCkV7XvLC6W0/GBIrOAMsiVTX0CC1AfcQW8YFZao+9Cap/4gkOTef8EmjLIdJE8FhzQbbRVAsDkBC/wJHvIWSbZ+GVet/Oc7HnQT2p3J9/suZD9L5NbQEtxBvgntUmA2PLjMvxIpv1s+JBIdFxpPwjcYuTm3d6j0WLibJz10vi0QD2GSoKptd2JLnBd3xNb4yLgx1v/P3hisSVwVtJDAuSEGnNnrAeK4soGLWW5HNlXlIog==;5:Fo+rkln34mW3xiqeZHZAJSQYXgdcQ5wBx7j4FDHvV1WYZZ8F1N4uZtklplQ/3nUE7HB9APwTOjjjSCx79Y9nxsnvlWqIsiPvBwwbQ1XEDbTYT88HQsUweBWXWh06lVc7YPdO6/WGtg10THVadrfWnSeydMzCHAsaEErOhkaEwwA=;24:g5djZ/bRbZ+M8vnmJKno032Qz4RMnICagGYQqeG8fePHmwiZshpdsdJHDi+cBqSmxZXA1Ev0m6c6ryNHHciALsYagQjf6lRkdUyaslYyF78=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3117;7:e7zrCX6o1tGEb/lbVhHh0dp6zUaTc8xDrkShOVAja/qh5pQ74zQl7C6zg4FCXi+obeZR0vUk5EMfjwdyE39/FWWbVlxoGbVQRa0/pfO3NWfnac8AF7BAM7HejveXy+a8ok5Cf2obXauyudRt3NVDthLCYl9bZOlZhiPX51TlJuypN8vDGSFRdQg0XB5rHBAKnIfxSk+DpjfY+bkR9MLP8C4Cpo8mATkwtLhFlFzW4B9aKw6GhDXXQ3uapVIwedK9;20:2ViQf9+eR+iX0gcDKzx0BdAGh/eTSy0vnDmoJXyD/y1DsPStPsjO6CS976R9CaDlebECX+U++BiXB+a3nKhSaSjvVMy83SBvnPOWstzSMo2EolBDeyaQ4lVtYNLRGNbRIViafvFH45Gqxqq8h/D6i63xuZtslxFEIVmNsjUzvjk=
X-MS-Office365-Filtering-Correlation-Id: 7bc5808c-fb38-46e9-a179-08d5cd4bfa00
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 14:27:33.5193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc5808c-fb38-46e9-a179-08d5cd4bfa00
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the flock owner process is dead and its pid has been already freed,
pid translation won't work, but we still want to show flock owner pid
number when expecting /proc/$PID/fdinfo/$FD in init pidns.

Reproducer:
process A	process A1	process A2
fork()--------->
exit()		open()
		flock()
		fork()--------->
		exit()		sleep()

Before the patch:
================
(root@vz7)/: cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 257
lock:   (root@vz7)/:

After the patch:
===============
(root@vz7)/:cat /proc/${PID_A2}/fdinfo/3
pos:    4
flags:  02100002
mnt_id: 295
lock:   1: FLOCK  ADVISORY  WRITE ${PID_A1} b6:f8a61:529946 0 EOF

Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 fs/locks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 05e211be8684..bfee5b7f2862 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2072,6 +2072,13 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 		return -1;
 	if (IS_REMOTELCK(fl))
 		return fl->fl_pid;
+	/*
+	 * If the flock owner process is dead and its pid has been already
+	 * freed, the translation below won't work, but we still want to show
+	 * flock owner pid number in init pidns.
+	 */
+	if (ns == &init_pid_ns)
+		return (pid_t)fl->fl_pid;
 
 	rcu_read_lock();
 	pid = find_pid_ns(fl->fl_pid, &init_pid_ns);
-- 
2.15.1
