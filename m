Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZq0TbFtCXZ+378DALQPq5KThjlIf4eKq3C/zTPt2pYplaemTw5MGS8uImr3wq6+66H0Kqgt
ARC-Seal: i=1; a=rsa-sha256; t=1526632945; cv=none;
        d=google.com; s=arc-20160816;
        b=t40k48FTtQ7X9eiHbbtOOUWM921qNGlwmGp5IIs5nc/3uk384hSLCYqMM07ezHbpPz
         Yy3OUL/BIIaFbjyhkq+pgmplurzz86VrzE6/RdUL5TH0Q6//YKiEiOEpAG2rmVVxfjCZ
         w5MVIpny0r52Ex8cfMucxjuHrfP/BgfElp1HZlMj313Ot+UIX3ABhERB7rngsBTRz7cl
         PbSAoZuxPtyNAXaQmnutcBmnLnQareZjRsVw5jciF8fdiV+ohItG//GXwqe61vUVi2n5
         bjydi6P+pGdASZgEZY25bYPMJDUpOCv8f5lCegm3fGOVolY8qk3llFjPws3Jqs/Os9Di
         YEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=6uPHp3B9cdoINQJ4fiXhav0uuPNAVay+O/UDNFBI8vY=;
        b=hdSyyx3W70VvumKxSdaZ1UgaR1sN5xCfdsTU9nL8mwyxKZ9OtB9MOSTOPTC4BICCdA
         2TaGbrON9udbXGB6Bxk7cZyFe18mE2AT4iYsj8FApZ7tWS/fCPzRZ1VyPgtrVpm4fnK2
         2YF0vMmGxIo8Jpu24BddFVKsQkXokwBmJfWskKROQ5fF+gytFeVUbChpUKOynjs+/gOh
         hFdb5BW118r6ufyoiBXjJgZQqeMl4yIFLObRysJpf9n5GR89d6XCESqN8KjoNJVp1icU
         5Hdo8yPLKvcy+6uFC1qFYJKUltiTqL+2BqJOGOBS/dFEgO3GmJo3oNX5KcscdheTn51A
         84Dg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=JtxLJAzr;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.114 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=JtxLJAzr;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.114 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v6 03/17] mm: Assign id to every memcg-aware shrinker
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Fri, 18 May 2018 11:42:08 +0300
Message-ID: <152663292827.5308.15476497557507652648.stgit@localhost.localdomain>
In-Reply-To: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0301CA0007.eurprd03.prod.outlook.com
 (2603:10a6:3:76::17) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:AvJ0aROTpVH2x0j5eo8ycmogvva96dNNPmOo7z2Y8rZfRe/vhQlj+mmsMlBfUP0mO2inyjz8/S61G+GGV4A5bv6X6igseoCWwYI5awipWdSphU8FJGwmh3m7fNjHXQiHnPMx5TRPmpyKNrNF34PSBZ7S8rG2JlbAwZOaEz3QvJZr2lo/3lLbVypptVEGbB5D4jOLobI87aoyup7w21jt+Ns1fgNQfpYIZLPb3gLa2NZxV7sqy9gsBbZfOpYmz7GB;25:asxdvhjLn+b9heahcsx5Notq/Pqn8RfUY3MhKYT2Y6RoXkrTwhnSNahZt35Up8xSXJUZ6OBFRgpDoZ1qadQd1tnqHXp+i51Ct+xsy2Vsid01JpZq/fC931l9fPVy9Z8Oa7qaaz0k4BJb3FisEI5SCneTCV1DHGtLPnEwSMimJldkokwh9OZZIs55Kz9bdvo/FQrFGquyV6nFZByAxI/dvVKVRvRsvDh9kjRlQljk9pyjcKWwDHUWBZ3ZusHVp4WvpG7vFqHzSVkNf1P1rIp9Kt+TodCgdYTC7IikM8z8zDN61rI55plveHalyyEUYC0FqH16qH5LRCTGubNu67CQ3Q==;31:tzuLNbWc3ucV6vWv6L6LawRmpNYjsRX4MLLX6r6dhXQruaZw14XGEqlANh/F1mUmsan/R8GzSTY7grcxJfpMtRuQkasv9YSuDEwufX7iEjPkDYhYncNJySanRwTMg1MYFWzbNMkjmDpzz+tELMI7/opCtM+dOZS3dK/b55I3yMbSimi1soVJu6RqDM+3MmK7o7PsZV30kcME5/nm2c5L9MEq7nxGMCKn0ZI30ar7kDQ=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:qIgHbSpxTiey4Ge0NrljlluRQU/6bJR4aHf2qGBGqD9N01DAW2+h3dWvI/Ag038Q3cTc0/et5cyFiH2I6loKbS8CrPktRiRAba1pcSjB2FDho3uTAIP3T5RKfcBOPAwh+rECdtT3fVu4KAh66CoTdhbdXwaI6K8+gO2jW758j5HGR/jiF6K0aKrqCGVSavW581n58Ld/BDD8aWi9uP7hC+Ktbz9n1P4MQvRVZWXdYS/B9QQ/Qn8gtG2oQCzRkXGVe+o1LmIMq6tcznH2fGZu0ZtI591f2AF6yrhwPjHwnQXwxRdpxl+rXrF+vPu62+wz427sGv4RXMp2Vg4j7nVTrsV9BgAJSYWYtr+Fd05Ffl8eENwXUkfbrTE0dG/3+AqtzZTdSdeRE6vvu0tbqvbyU/Lvdls1qsZoOd89yVr9lIOHsLQDfTvpXpQw/VO4dCNe7ljcOp3ZcT5GNoL2HIQ3E1JYz47Uqc/4Jl96g6Eu4U1cJhSjbvgOKVSaEEJEoNej;4:g2jR0oKhwjnJqj34dY7Tn5H5m7DnTQ0fGuLe4e+aYYTmof0j8f8Oi+MqfP4KI8Zf6d8M4eqQy3ZlzcPeGo8RwlfP6MA+8ZgjQNIke5EkWr2kGevD84eFF3DAu7s/URNKzg9kURb1QJ/NArKh6h0K1h7YA2lxcRcMXYbHBi9Tt58mUjIwB/61lzSVhLb2/CclEsrFT6++B2FeL73cwrw98XPm+KTZfVqfWRwaxc1CO3MXdpcX1rybwGGXgLMzG0ZjnvIYjb5QdPZ4R5YQRyakaQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329EAE79B79A1DE6026B344CD900@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(376002)(346002)(39850400004)(39380400002)(199004)(189003)(386003)(6506007)(9686003)(33896004)(55016002)(956004)(59450400001)(97736004)(476003)(86362001)(16526019)(6636002)(6666003)(53936002)(486006)(2906002)(11346002)(81156014)(106356001)(105586002)(8676002)(186003)(305945005)(7736002)(55236004)(81166006)(39060400002)(8936002)(26005)(446003)(103116003)(52116002)(5660300001)(66066001)(7416002)(230700001)(61506002)(7696005)(50466002)(68736007)(23676004)(2486003)(3846002)(6116002)(47776003)(25786009)(76176011)(58126008)(478600001)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6Y2pYOTdZSGNlZ2lRNVN4eS80bmptNG9X?=
 =?utf-8?B?QkZqN3daNkk4RGNveXVpUTRIcXgyZ1BzNEhZZTQxUDlTV0t3U1JRa0VzVnU1?=
 =?utf-8?B?SS9GZlFzZFExbGwrOHVnVnhHUEd5MWtscE9DeXYvdWVjUHRoYVhwM3drTEdJ?=
 =?utf-8?B?Y2thZ1IrMXZ3VThHakNYcTh3RzF6ODhHMUNnMFhwWnVZUWo2SVVwY2NXaTIv?=
 =?utf-8?B?SW0vSkRPRVIrTnJ5NXgraHBJbm55RmxpOVU0NUsyS01VeCs5YlVVdU9Mb2JW?=
 =?utf-8?B?UGFOOXhjOXdRS214U1lzWTNqSnppbm85dm9ZMGhrSTJQNWp4bFFueGdpWDVY?=
 =?utf-8?B?SCs1MElicEl3czB3QUxvTUozMklwOW5QdUpKcmZaTjRIQW9ZaGM5Zjcrb2JT?=
 =?utf-8?B?YWY5V2VZZXBCUTFIUXRLQ2t4eGFkbEF2QzhZdEFSN2tKYXdDbEU5eEhDdGhx?=
 =?utf-8?B?RHZPdWhORUF3dUxHVUk0aUhQSUtYUFZQT2hxQzV5dzU3YkhsZUUzTVl2dWVD?=
 =?utf-8?B?NkRnblNGdUIraGJWcXdzYjV4NmlkdTA4OHNseWUyeDZ2TlJhSmVnNEZ4bEdO?=
 =?utf-8?B?N3NNUXZGeFVYYUl0OGhMaytXZzdpSzhQQ1BNN29hc1NnRXNYY09lTFdpNzF2?=
 =?utf-8?B?eVE1MnR5eFA5UEhFSWY0b3BwYnUwTVNneFhacWlNT1dFSDdjUFVJNHUyL011?=
 =?utf-8?B?TVFWUmprclc4UGVMcGlIQWE1dW93ZmVxZ2t2V3VNYzBKUERPZUg4RDRnaEgy?=
 =?utf-8?B?c0xRWDBsZnVKQWx5SkpBUStKWlVMU2MxVXh5MnJSQXBrYVpoc1ZPY2RUMCtW?=
 =?utf-8?B?UzNUZ1N4RW5CTm9qNUkvcjBSRkJNNnRoaThBdytTL0E1OVNBN094K1oyU2VJ?=
 =?utf-8?B?d2Zzd3JtWVFrWW5uRy83ODNUTGd5Q0ZyNVVSQ05TbXZGNUU1ODlqM3N3Q1FK?=
 =?utf-8?B?K083dEgyUGpPRjhDdS92UE40VDU0MDVpd2JPM1hNTDhPQjdFN3pXOHNIOEZ4?=
 =?utf-8?B?bEkvdzlmU0RLWDlMaG5Uc2srTi8zSDU3TU9iT0xZWDdGV1pPM29ZMTFmU0Yr?=
 =?utf-8?B?UTRBaHJMQndZQUNWU3VvL05SR2tZNllUYzhoWmRqZkpSSFJvczJKczc4SFNx?=
 =?utf-8?B?ZXRMT0JkaXJFMlNpMVl1ZWJNOFAxUUtkdmxqQklFNkl5OHhzTGdTRkRPVlp2?=
 =?utf-8?B?a09kZkRvYWhpUzdpQnlJemtveFk1QzAwMWJFZnE0QVZFd29JcmtkZW1laVFX?=
 =?utf-8?B?dGVjaG16cFpWVnRpR2pEWmk5Nm14NHJwZU5WbDhzb1dxSEJHU08xa1Uxb1Rn?=
 =?utf-8?B?VXRjRi9iWEI3ckM4cjJycWJ0NVJMSlhYZE5TU3RBcFdPSG5GdVR5T3QzN2tL?=
 =?utf-8?B?djlHclRRM3RIUTl0ZGdYUlRVeDJ2Y3pOQnBNVmtML2RucVEwcUdtcGpReXh5?=
 =?utf-8?B?QldiMkRoMWM5ZUFjVm1hVUlLZWEzeDFHRFNSNXdabWNFTlkwTm02NTBIeU50?=
 =?utf-8?B?SzBGN1UxdkovZ01xcE5jOTJ6ZHlXL1pERHBHeDAzWEdsNnZSeXpnV0gwc2Zj?=
 =?utf-8?B?ZjhtQUNsUkt0cW56QnVoR3AyS1h4TnlYaS9aMUtMZmJ6NFBwK2dBbDBZYkoz?=
 =?utf-8?B?K21EZ1pRUVFTcEhZV0V6cHVSRXlZMjlsb1ppeHltS2IzOWhnRE5VWUpLdlRh?=
 =?utf-8?B?dTIvOTl5RnEvZXplcVgwVTNRdHdVaTczYzBTeFl4TytrTC9qOERMWTJKUGlj?=
 =?utf-8?B?dmMrTFB6V3ViVVdIdE1kMWJ6WXJ3UkpHYnRCYzY1dDhCeFIwNnZSYUdnZ04x?=
 =?utf-8?B?Z0pBd2VFOHhUTGhKdUxHWTZJZ0QyVEszVndaODhUcEx3YWdkUT09?=
X-Microsoft-Antispam-Message-Info: /wyIjeQNoplx4IfFBW8PnHS5IgJSja2PHyfv/Cpd7c6jwfT0GdnpVYcxglJL0i8/7Fwzc8y0EeXyAbq2vuW8uFQiDCMJSfvFgOna/0jCnydfUCGHFK+RepcfE+w4Ro3D4FTNVOmCb/64uOytpQ80VaxZFnw0f6S1DZnnalZ7D5eY6PVNlY4LnPNxBpFt4mOu
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:kb4EAzOsM2C2N6/ykZHPdlUvAb2WUJzHa4Lm2ZFZuDtcFcFIbDiChtCw4tlkEiA8fBVsJY2LfGfHMika/Xa1SeaDwuLIGZkkHKB5HrYhgwB64FPXoS3tTUt/PIESF0okLC27UyF0EVYb6PYhWOLz6Q+aOQ2Izb8psJYA9TzxgII67vFfWpww9T/ylZy4d928P5Gls9OoYfWEUb+pB3xVftNjbm3TNHQLQOMUhMF8zmGvNseVJTXVmvytNC7FUOa2k1la5JAbQEbQrDM9jXRBujgYf4KnXfFSWfSLOOlwnKr+7VZmjOxdLr0aw/25M3+k+nwGdRNbW3Cc6AnWmWKZcoclCQtg1gE2cjFxhdKY7iFRk6ZJr4/focjZpCsxmVedp+y2nhqBFhBeS+NhcEMVBS4vVKbTFBqiz+xBKSNEHtA8AacLbTlIEwj4pqMwK1ab6ugDgg96HGiuwxZtLiR3Vw==;5:UHs+qwYLx6u/g2tNmZjkj+b33i1NbUHBZKZUi6lOijTVnf8LYqY5ompBACJ/NduhWtna3iePW7u+3y3QPlImL8mmrj6nvSJPcYZqKFb5x6B6Aa7q/BzL0Ld1IMaynqEg9B6Xghnos/VsBZw9gm9iKzgANnT2SoqFzbWYQu8ZX0M=;24:rJQ1i35f2xQ7NbCBJMu1ywC8g8hcvzqb11MHq0vaMnnd5kLjGk6CRbVKIPLY03I0z0R+AiVHBlbvvqwLZrIzgY+a4Yy3Wm1VDTMWELWKYyU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:/1StyrEda/eKQtwhugv7Mrlym2H2f357Mp9P8HY0E+MK+C9JW0FvKDIHLtYzojtwQW/opQ4EK264LZ9tacKuj8kmpf/B6PiPzRe9eYQP+MuzbQT222kUZ0UMc+W6E8jOrAfRHW7aFdMENvBtiUFipz/FKCp3dZ/Ap96ngV20b6luWbA59fzV0yvNcus2U4M8TYi5SG7LgzwUlIF1LRaf8a8QfZia8+i0wLbEtR4Y1z4RkoyDBvF/8mNE8nBgxRpj;20:11CmJSo+0iWqAjJq0+vdGeOUaXmPT7zd7c0KRXF44JJ1IK5Ohk4QwPbQF1JLuy9DWBRaASZkLhAfydPvN4kKJWODM32XXhTwsn7kSiAorxfe7HaioxHLF7ZDuDjh6J5cLSaZR8AhyqY7ah8NykHXOTSfZeU+RLxJMRc43fG+3xQ=
X-MS-Office365-Filtering-Correlation-Id: 6c12a0bb-3bfd-4767-d66f-08d5bc9b41c7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 08:42:11.8734 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c12a0bb-3bfd-4767-d66f-08d5bc9b41c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790667244060428?=
X-GMAIL-MSGID: =?utf-8?q?1600790667244060428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch introduces shrinker::id number, which is used to enumerate
memcg-aware shrinkers. The number start from 0, and the code tries
to maintain it as small as possible.

This will be used as to represent a memcg-aware shrinkers in memcg
shrinkers map.

Since all memcg-aware shrinkers are based on list_lru, which is per-memcg
in case of !CONFIG_MEMCG_KMEM only, the new functionality will be under
this config option.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/shrinker.h |    4 +++
 mm/vmscan.c              |   60 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 6794490f25b2..7ca9c18cf130 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -66,6 +66,10 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
+#ifdef CONFIG_MEMCG_KMEM
+	/* ID in shrinker_idr */
+	int id;
+#endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50055d72f294..3de12a9bdf85 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,48 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#ifdef CONFIG_MEMCG_KMEM
+static DEFINE_IDR(shrinker_idr);
+
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id, ret;
+
+	shrinker->id = -1;
+	down_write(&shrinker_rwsem);
+	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto unlock;
+	shrinker->id = id;
+	ret = 0;
+unlock:
+	up_write(&shrinker_rwsem);
+	return ret;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id = shrinker->id;
+
+	if (id < 0)
+		return;
+
+	down_write(&shrinker_rwsem);
+	idr_remove(&shrinker_idr, id);
+	up_write(&shrinker_rwsem);
+	shrinker->id = -1;
+}
+#else /* CONFIG_MEMCG_KMEM */
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -306,6 +348,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 int prealloc_shrinker(struct shrinker *shrinker)
 {
 	size_t size = sizeof(*shrinker->nr_deferred);
+	int ret;
 
 	if (shrinker->flags & SHRINKER_NUMA_AWARE)
 		size *= nr_node_ids;
@@ -313,11 +356,26 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		ret = prealloc_memcg_shrinker(shrinker);
+		if (ret)
+			goto free_deferred;
+	}
+
 	return 0;
+
+free_deferred:
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -347,6 +405,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);
