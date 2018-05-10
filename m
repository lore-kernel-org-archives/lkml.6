Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZqLla5kjqUL6TjHlqaJX2nwquUd0kTTRulj3jKgA4N0/prgehQNy5C0WQHxOmcxdgyv734V
ARC-Seal: i=1; a=rsa-sha256; t=1525945993; cv=none;
        d=google.com; s=arc-20160816;
        b=fhKeaGnnmvZ4qpr+pnVnzxXIHH9whI54FilQcV1A74FfBFWkb+LLUxB3uN4tJihJwk
         E/q2W5clXCMye+JrWPoatoeh7lFhZTdWvt7/u/Lx/Pnr5giPeHc1jBCQlZauXN/fdX2e
         jCJIZG+JRWzyie4NM8uFRNh7AHs7bZI7/B5KAVdFsEoGAQuEZ4W9RWUf4LAH1e8QPEcy
         nlwn3pok1oDqbpaH1ruvnKhqlx/xh8xP4VohnSPSGYarK++gRjy3ZliFGVLn2WLbz6hk
         vhEk1qWTzVWB2n4Mut+uf1Aei4lBQj8NaOpFkrvagvbf9wpf4z1mlnzZyBBsuW3T8Qn5
         vrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=8/B+TBMb5ysBcID+OJHfZs70BbVua2S4F3QxszUwNac=;
        b=X6FHQj48gTk7uHKewychgR3YplLZlrlRHX1pbhF6YhvpGYtzkb3GMmDLDMlQZAEm5m
         8Nqfoln7+Z9Ocl4ePWCQI4DjhLcSc1UUpgdtEnMk89y9nnNPAfD0JckLKQOuuFpog6qV
         49B07M6RTBqQ3SYmIddEG2mhXvvXpVZAFH33z4/fKwiPsNOITVT9YCIap4o9Pwwktc40
         sSX8c0Xl5OWt6X7km1jTZBDPpz62NhaNAgtbWkDS9h/VlQGjafMfVuD+2YDROrbYCPZi
         T2tPp3RPghN1+qOR/+roYg717/kw9E2Sn5GgovFmGbpOEVuDKjWxsyarKUfktnT/iJqT
         OgHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=T5vAWpaX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.118 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=T5vAWpaX;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.5.118 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 06/13] fs: Propagate shrinker::id to list_lru
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
Date: Thu, 10 May 2018 12:53:06 +0300
Message-ID: <152594598693.22949.2394903594690437296.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR04CA0025.eurprd04.prod.outlook.com
 (2603:10a6:206:1::38) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:JngpSdornpL9GasqrXnvQyfmtqLvsxGJDHN4qqGehdsuvp/0lw64wCCmjV1pG3GUm/bX7f8/USZZiQkgB9KRwPwvP2fETqePLWCDIMl9EYRTCOvaD+T4bDEDJMycHdZgH2aNgKxjh1rkWfTOoKV79WuFwMvcXjzpBolcoHEMfvu8LahWtM72GKxBVEtfgGQvO6MNiEXo0JtEcFW4s12tJubcSXNYMw1Hjh0+pkwTwGKU+lbHi0wmY5W2FOUgJHdl;25:ox25SS7RlvNnI2BKi+UP/GFWc3dDI0ePx7VJrLiUVoj6gQkmjf+GDPy+2igyQ6J3ZEFVVYChQcjaXyBX2v51S/tOsGW60SLsn69eiy6uoFdQO5Zs07dE5IGD2wvZykYBQ3BdMEEmHw+cX+RsQtsedaRfCm25MeQHLO5KgPuhmBvzJAwK7vT+YtJKYj1+RIcS+jPlEm3al6FHDsA5holCQReUyUUnyoN4/c2NL3TbiCVmiL3M11Ag4bgkVVzfl5hE0inCuiaTCkN0KBRSg7kF9P1q9s3SEHaa4JOfOqCHAD4NLMpAREeI9HCHWo/mwoU3LqlhEudlNcsDuTsH/rylJQ==;31:y++i8r7gtp9S7hVyJOEA/UHpluZLEM+GLPhpZwjx3vGjgVXAVKpLtkVcSFo8g2WTgSSXcRZzyldLEJcGouTgu7Zu+5IIFyOkmZivrkxbXMFDuZ3IjkCn8+OJ1fDSnp2RjjvRP9K8pjCcoTrUE8XxU21o4644y/69uGLKg21+DfZuKk77N3dhu+dE1lxCR/IEM8zBdpqYm6oKgUPRRPsm8LslGiFfd2fB67ygsOcTMxs=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:6obh9CGjBuZRpeZ9BXB4a/shD5iL0ZUQ3PrrDkAS/kZXdV81gWxj0mpu7DHyzm2+6o8TOzW3sGnotvp1l0QQxhLCP7G27lwo48bRr4Y2Yc7cDHp6STSS8/s5Gn4wYS+FhNi1/tANfOkJwwIrapkj5aeX5ZHbfuabqxnBye1W4q38ka8cPlAst6kAWoQSGMVw/3nWmjro2zjLosVWJAWyEMGgU2cZR2yURgDH4WRDQqrfrnHcV//yCmxGq77uHc2GALprB+IwcEZlcR77Qj2z3h0xA0++pt7cfwXFiWOJPSZrwFkijC5292Zm+zDcFBmFWM6VHG1vo36wI3JKfo68WE1SuFhqCVIc6ep7a3Vn0QN9WzSettKezQsJxAqMuLKbqXngO1y++0fGfEsMXcsIy6Y2f+9I4CEEuUdymMVKLV8l/tklpkIvGMG6hX27QeuHiWnL6DgDOf5nWsGjGZhpwK3kMi8FA+J1fyDdi4ar+esjoyX2Y/1rpBxip33LgfYq;4:tFA62DsYPeWBnc/Uj7Mp3JzCzVngzSsUisxTYei55eIBYuh2TKB45yRSQqYmZ2HhvrZ/96D+D39uoQT+CLaO7DcnHQTKSMWIsfSSVtMNGj8ZO/Bx4B9Di6THq0hhU/GgtoPUoPzY6mJdw83w+bz2SxcHdm50OMZlK3/p8czy3pAsGs8AoBF65/00AyegUkij6Bo/k7oMNewdxeykJqVXgTn9Ig1v305I2rJgB2lSjqdDOThOmy0RSlKEyAUMd+r8036AQiG4p2wlNy/rZCfLnQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1331D1A94B6DF1029285AA1FCD980@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39850400004)(376002)(346002)(396003)(39380400002)(189003)(199004)(6636002)(8676002)(486006)(956004)(316002)(61506002)(103116003)(58126008)(97736004)(39060400002)(11346002)(446003)(478600001)(47776003)(476003)(50466002)(230700001)(305945005)(68736007)(53936002)(105586002)(9686003)(7736002)(106356001)(55016002)(25786009)(386003)(3846002)(55236004)(23676004)(6506007)(52116002)(6116002)(76176011)(7696005)(2486003)(86362001)(575784001)(33896004)(81156014)(7416002)(8936002)(16526019)(5660300001)(66066001)(186003)(26005)(81166006)(2906002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6RE02SnRVZUsxeDE0STVHcFJ2TFV2OUtw?=
 =?utf-8?B?ZXZ5eVRJbEducFVnVFV0Zm04dFRKRjNzUkxoOXJjSVY5YjdHeEV4eGlKOVE4?=
 =?utf-8?B?U1drSXUxSklFUS8yc0tYdDc3VXhGMEl0RFZRZ3pPSWFDaDlYdHJmZEh2bmFC?=
 =?utf-8?B?WVcwaHhTd1lyK0pUclhDSHhtRFNCRGhCWStDYlFKWGcwdFhqbGV0Q3RYOW5n?=
 =?utf-8?B?U2JrT1l6MUVmNU5jS1RLZDB0SkowTUNGRFVKT2xXVjNsdVVjRXk2NFgveHJy?=
 =?utf-8?B?cnZmTEt5REtOV3I5SURsUDI3U1hWYXdMYmlYRzkrZVVDMEFpb1RKMVZraU16?=
 =?utf-8?B?U21NSVlhbWUwVC9vOFlHbXBOYVBVUXhuVFhDbFB0MXZwTG55SDZ1ODZHcDZy?=
 =?utf-8?B?M2lJZnFDdk83SzFhK3pnSFhNY1JKajBZTDdwUnZSdk4vVFhIN2lkUXdUZEFv?=
 =?utf-8?B?cU1KSWxIdm84OHhheTE2VzRjQURSMFNJbjN1Rnp4TWNSNTFHaUJrYnNMcTJ4?=
 =?utf-8?B?NG5UZllkaHNIcVhMdEx4VG5WMGF1V0grSkwrRnJsT01NQXBvQ3JaeGJOM29S?=
 =?utf-8?B?dzRidWN3emZIeHpJUEZtcGJaWXA1ZW9oNmRxellFYlZXU2gzQzhKdTNBZndi?=
 =?utf-8?B?K3JBVU5DZ3hLdEcwOU1HZWtINWZXbHJOY281VHdhUUE0MUE3SDlLM1ZNamFM?=
 =?utf-8?B?ejdXNVEvWC8ra3RpY3JPS0w3RTk0SVdMU0FPRXk0S0x2VzdFd0pnZFBFSENz?=
 =?utf-8?B?a1M5NXJDa0UxVkF5UGw4Y2ovaEk0bHUzZHZFSkxYdDl6aWQ4QTdZYVhydzl4?=
 =?utf-8?B?RFdZQzJ5b2l0R3dBaDQvSFdkSjluNHYzMDlxMzNjNlgzTWhockdZSnMxTmt3?=
 =?utf-8?B?cGpUUFVRY2ZRNXM5clRBV3IvblZxVzRYdUVFOHU2d3E5WS9NRk4vdjc2aXF4?=
 =?utf-8?B?eFpuQ3Z1MGZ2T2h1bWQ3eEpnVm9yb3RTQ1BLTytINFhXWEp0SGJrdlRjbjJh?=
 =?utf-8?B?Yi9BeENKZmlNQTBkU2dkdy9hT0RrUFBQRUJ6cnR1RTBmUGpGbDB2THFmOGtq?=
 =?utf-8?B?Rm12azJsQ25ndXh2M1ltaDNpUUdydTFRck91Mms2TGJtYUVWTW1tenFMNWc3?=
 =?utf-8?B?UW1rS2NYSC9LKzdNOGQxWmdBbmdUVk1peThBVjlDN2E1Nk5URk9rd0Q2YXIw?=
 =?utf-8?B?aXlWbHcrQThwWW1MWFNZTSsveW1TWWgxY2xiZjRsMnBEQWJ3ekFGaXViUzYx?=
 =?utf-8?B?WXFIZm9JK0d6b0ZpbUh5NXFVM2FPQTJKK2h6c1RlK1RWRVYrd2Z1ZUw0VUVH?=
 =?utf-8?B?OW9aNnNyT25TRisxN2NmQkhKTEgwd1RNWTR4NEpRbGNFd0NXZ3JheFVrZHZK?=
 =?utf-8?B?ZjdlYVFla0thalJVdzFKT2V2U1NNVXgyQXFuNURmb2R6d0ZpZW94YjA2QnBR?=
 =?utf-8?B?YzNzaHU5MHcweWk0QzVNL3FmYzN3Yk10ckQ1MHpQWmxnTjZBenRFK1RLZ0tD?=
 =?utf-8?B?WmVYYVI1MFZZaXkzMmgxd1NDVFEvUlFtdjU1dC9VTmRHV3VCZFQ4a2VQaVgr?=
 =?utf-8?B?aldTc2psL1ZVc2JLd0J6UXJaSE53QW9QV2pUY2RvLy9WSGxKNS8xbUl1dGc1?=
 =?utf-8?B?UXE5THNRY1FmTVhqSU4xVWNmQWZ1NjVFUEVUZW4wdXluUGszSUd2N3FTYm83?=
 =?utf-8?B?dmlaZkUvMzA4Y3BpbTgzWStEaEZlbDZMeUtWaG5ZRE1SSnVXSEViZkdmZ25U?=
 =?utf-8?B?N2I5azh3VWUzSFg4bXdNYjFTN3JvY1RsVjdqWTh3cWdKcklFbnkxR29KZnJW?=
 =?utf-8?Q?1OQAYCe6P+PvTnq?=
X-Microsoft-Antispam-Message-Info: 3gZvNobdTgBnO1yK6bR+eCtwL5sWK2KSYE1AhvL6LHgJiq2h3XwThp6esbLyG9/SirLK3ITLWTViCilj6Zf0ysAD1OOVL6Mnf+kiIpJwwj137uFSf+MAEwkv+8c4Z59VL/3S/jEyjw0VMHJ9Lpu40gc0OUCgRUkh3DAtNoROlyZJkhIN6cnWMnE1Ml3zSiAD
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:7Y9RZjl/4P1Bcv8PiKGwIjlNKCub14maq/M9Y29AdXgs66xP+fmInkd9XlaXdI4uc04Aho2mu7Gh5jBdRgAxHTpo509n6YiqnMoDSmyVbpOJrD3iPd4+qX+UJHYn7n5YoX8LPhEi6HQsarVzOQv9jGXPy24auWNEaJ1/DMLln8JORV9Mj2KofbpLT/pGLTlHCOf3hEkDWvQoJkcVfrpLo3t6zn/sgTEvW3+mafLcHS47B+ZyT9RfKeY6EM5ZQWwVxKcMKSusWATIN7UnLt2scrTJjxdgRI4qQBftJg8rvzJuzVn+dqWCZYsUiYcgP/3tF22hPnGtQ2mEl13dbuzOhcVKs+h6odAblZRtZDxTbFl6hn377KxQz32Z2wAfdglPBGZAlRTEfWdUbKe+OsAl5UTzNmNSSyNdnI176y8JMTji4XLIRk9QqyyVxm9qHk4OZge/DLqPL2YjrPkRmubLlw==;5:W1a7qUqJlqvoO2+KhcwlOIlK8+mtFZpkSZ9+Ah/DA/iyvsxTU0u5jYoxZxs1BDd7qp3R7cYaIsAnt8LrnXvc1GK9ohTQ9WvniiHellRR4sgSaQ0ewyh0GKDo5kPzwa17LUyFGod3YH/xn85csPA5sa6wxNbEE1T1REVWNjiXQeE=;24:iEgrPO9EcFARZAtwf8bQ2uC2vIccjen2n1ZWCHbzUQDauenqbgppgPA4fw7vM1kPpX6wgBZt5WC060nxjgVZ8o8mMS2dsnesOIFQt9cj46g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:+mo/5wi4VShVXmpNiStt+Vyib+De8ss/v4TCblSl/Y4HC18p5eZXXzRij8chQVHV+swnNemEPhd4Yz3laCqKbD6PzSvebZkaW0C1fhSbUMNd3WQqYzlYGCRjh74JGU6f4wjh0Whba4nWC5Qv/XaQjKv4HHB/tSuf7YUL+i63e63F4LZTHLf7h07NwXAbD5QJ1UcmraR5kYataKagJ/NPVtxr/tLG/aP8nIgILV+lAI9PwaCCLq+x70YK1uIjkXWY;20:g2ewZ2aH6/KyYko9VIblaa/0bpBxBbtigbYJ2bU5t4o443eXe78WsNARLHSkG1K8WqlrjnwTL7+ah+7FitN6eiGHhOoHRR+Jb/Wz/Z6ShAinJNM4jBm69w5i9tD3L5xcpTHdMmsYc2f1wIB8HTVL/gG6m5sZK+MBbTQvcE2EfJk=
X-MS-Office365-Filtering-Correlation-Id: 4fb5d06b-845f-4fb0-8e41-08d5b65bd69d
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:53:08.9051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb5d06b-845f-4fb0-8e41-08d5b65bd69d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070346813073089?=
X-GMAIL-MSGID: =?utf-8?q?1600070346813073089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch adds list_lru::shrinker_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    4 ++++
 include/linux/list_lru.h |    3 +++
 mm/list_lru.c            |    6 ++++++
 mm/workingset.c          |    3 +++
 4 files changed, 16 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 2ccacb78f91c..dfa85e725e45 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -258,6 +258,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		goto fail;
 	if (list_lru_init_memcg(&s->s_inode_lru))
 		goto fail;
+#ifdef CONFIG_MEMCG_SHRINKER
+	s->s_dentry_lru.shrinker_id = s->s_shrink.id;
+	s->s_inode_lru.shrinker_id = s->s_shrink.id;
+#endif
 	return s;
 
 fail:
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 96def9d15b1b..a63b7a4abc6b 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -54,6 +54,9 @@ struct list_lru {
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 	struct list_head	list;
 #endif
+#ifdef CONFIG_MEMCG_SHRINKER
+	int			shrinker_id;
+#endif
 };
 
 void list_lru_destroy(struct list_lru *lru);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index d9c84c5bda1d..8dd3f181d86f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -567,6 +567,9 @@ int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#ifdef CONFIG_MEMCG_SHRINKER
+	lru->shrinker_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -609,6 +612,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#ifdef CONFIG_MEMCG_SHRINKER
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index c3a4fe145bb7..da720f3b0a0a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -534,6 +534,9 @@ static int __init workingset_init(void)
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+#ifdef CONFIG_MEMCG_SHRINKER
+	shadow_nodes.shrinker_id = workingset_shadow_shrinker.id;
+#endif
 	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
