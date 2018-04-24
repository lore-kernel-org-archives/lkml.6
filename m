Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx48l+jIrKihSUnBwwhP2JElmlSdi7g0y7gt50BUw2fk0992pwSyTYYPO4hAzKoGk7Yz+sIx1
ARC-Seal: i=1; a=rsa-sha256; t=1524572027; cv=none;
        d=google.com; s=arc-20160816;
        b=C+/+JYlhOZqjUlsA2q7BJ6VavDbKfEx+tzh7YGoE+74uzjl+7IHPsZXBIknYAg5UCN
         g1V4K/0Gx2xgdZf9r/v61+vfn2a0uGRhE8WHgAcmulE0DZcJRlfCIgyiAMyyUBtdNWlX
         FJfC+8aULXc07Ab6z9Bt8tj7w9C/G05CMQD3seru+Z0kMvEYMMOP962DXcVO+9PZGQf5
         DGOgA0OMd7uGhPfchM1ZgXM3J/ojogqAafBnxH7eQrzc9z36DppmrzTx9gcDF3Lvctf1
         u1VI5+CIDkdOgfi8riLBgcfUFo68Yk8LD99qClwQiVJS1vrYgJrOhNrJ32bfC7OpHUSE
         bamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=gYJk9GlTnT4ztiui8wqRNk2VpDU6MG7btK9SWXHYvxw=;
        b=BgHr+Zy65mTjIeeeDpw5vNx4Atm7uNbOLQx9d8P63X/bgMIzcIIHxKIjBGvV8EVnSZ
         akwsJcH0nHPtt/+P2jdpWJ6pLYg52Xxnvuz8iakbfMJNNgO2M8I7iNaI/RbBag4/3sy6
         2IXzcTNCFeR8ttPxqEfmHpDmDTESPpNhvq5NV/KL0N52spaLNmC5fwNzBQOOx503qM9H
         Pj9CvjToSqx2jH9WWpXqiKwQrcutssouTWXDZQNbYahS5ZVKo6cbjG3mlgbTDew5VQiV
         Bxe7yZNOSjSyUyI60L7GmzynpS8Oz/Wmtu0HnQb4Ba1T4WPQcjyY98FlpJCOQi8H5fSF
         4qhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LIsLFjby;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=LIsLFjby;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.110 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v3 10/14] list_lru: Pass lru argument to
 memcg_drain_list_lru_node()
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
Date: Tue, 24 Apr 2018 15:13:39 +0300
Message-ID: <152457201976.22533.10859603213961853520.stgit@localhost.localdomain>
In-Reply-To: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
References: <152457151556.22533.5742587589232401708.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0339.eurprd05.prod.outlook.com
 (2603:10a6:7:92::34) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:vSpqHoa8NONkcWN9+kiz6GQvW3Wiz9ghOA+NH86DackU/vVj47D++gmvQvX+4CIzMt6fGu5qLjmm9PxjRyBf1CTFw9Q0e/NDiK29AbfJ8N6y4Gjf4GNIvUyM+F48Q7Q1EedpcUy+L88nRH0MtNVcytn3CoXEaOx/aGBUDNsbSjBZLZrXkvtVm0lK0FLK1sztjeqtwlt70yHaJnKlRDdeh99EKiEguMflDTlINQnkM4tbusBk4eV0Wdd5mEJieFsC;25:W3foS8ZKNIevWWywXaE5bcEimQXlfM6ft10zgfkjtPnoJCXQUzyE5geL1v8cdfjnmUkgvKIR9AjPk1sqQBmJni/KUHVJux74mm/heOqT6VSl8tv9HBCxihFmkwB459TpBG5nq755jFXjpTxKkCsa8cRLGmvVyAkLINkOHrs+iQdtLk9QZh+kqhNew6lAsTa79eI993hHtJ5+SxQqv7r05AMpYwKkGzrI0DjZZ46UN1muM0zo0ND7s4dOtg7mSWceHlHGGPGEa5VoJl6cocZCP5g4AjEUpp/KTyN8fG1LzYBArvBeDk4YhbSZQXE3xoAn9DURzuXDKtqZBNDjrq7eAw==;31:tjsu9PTu/awetg2hoMr7RuWzIYKK3Ay+ThOH2xgogPQjvpchK8Z9L3PxYcXiVsVfizrZDcBxtCM2dDGXmJfWi91mb+8Hhwy6IdFrQ/IKfDDaYfqxK/O7vNDUJMYoauy9Yj6aGuFsb+AKxXQjAt7wSu1654JS1WDuZfcRLEY/1dKDYVbQShw7NVbfqZyVztInsnuk0QMpakqOW4wknGzPUzaRze/krN2X62bVTC3Bn/I=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:3wvLI18bIkyob+KNrhbszoSBig141gxEUbTyyoBDsTG1DelQGemlRnOb4uC5tuzFmI5CsrYZUOESqqjjsp3Zz62gOI92GYMDOWOl2Uzq7RtXdgz1UygLT7LG6Ti6OL2OzGboRQbj9Qi7DfkEj91GEyQrybFBOzdbBC0Yy9MNP/Gotsh+SUtRO1dL8sIba9nwzTW/jlR6RXRh+AxAonzE1bL/NUAZK1uVy6UnAGoRTWl8Hq3XUSOUZguh7W0UnM01mfCGIzIhQybGJXW0le10VljsDowKClMlP05YI3t4We/t2Orb+JLZNM1CqGvC5YLT+RjMbuwPKxEjUh7yd+KSIMjr3/6VR+oaQEFKfmybEItYHJsZLHzZ42MN1UMGqY45lR29QGVR4DBwadgkq/kJEEMpg8saT0862z1t9ib3Vy8vZkn6OhZlmJay4KaI0drYMJFDC4Y0inrpJaPPuam6tLfH25+DumHydukbC6jBn46QIRzOIiYIJ4Pi/xy8QRYC;4:73G9foNfJ5nI0QX+A6ls/5MNOVS3OYt+72IBlJMc+23NwFVY80ZPDKjJvzsFxdgw5YzW9rNK07IfuheMJAs032p54RZXO7tpvP54CTbmzFI/5uATKvhttlfayMZF7fs7PLMk8PcF2cPQ08LibfzFfRRpv1IQtiB9g1D0m7XyU7CxeviNfK+a9l4cPuBKAG30HuBj2EPl9zbKkgCy1Mtg5Rkw4FKglwXWwV7jXbQubecXvPMfi6dpzlbepm4NPRzj84b7Gz1nCYx2Q3i9xBH6ew==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB13318D8B84EDF2A74B4673DACD880@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(366004)(376002)(39380400002)(346002)(396003)(189003)(199004)(956004)(58126008)(68736007)(6116002)(476003)(3846002)(61506002)(446003)(81166006)(81156014)(316002)(8676002)(8936002)(11346002)(33896004)(230700001)(97736004)(7736002)(5660300001)(305945005)(16526019)(186003)(486006)(39060400002)(575784001)(86362001)(6506007)(7416002)(386003)(6636002)(59450400001)(106356001)(55016002)(7696005)(103116003)(2486003)(47776003)(478600001)(55236004)(23676004)(52116002)(9686003)(26005)(66066001)(105586002)(25786009)(76176011)(2906002)(53936002)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6ZmJqcXdqTDRheUlqeEJjZnZJOWhhNHlu?=
 =?utf-8?B?OC9zSDcvbmVwV3pjd1JtK2pqZEs0S2x2a1FBT012Vnp2WExNNWpTQmhraFp0?=
 =?utf-8?B?Slk1dHo3UGFvMVRXWGxEa2VMbVd6Z211Rlo3RUMwa0JhUUJoTFJqOVVMWXhX?=
 =?utf-8?B?U0g1cmpJSEhQZVRlTU9aWlEyTm9HRnE0WFcyWGF3MzZrTDI4NjlDZ0hIa1kr?=
 =?utf-8?B?V0hFdFdLdVIvUEY1SE9TSVVPKzU0NXczYjVTZXBzemwwWkFabnZvMUhIemoz?=
 =?utf-8?B?dlhjYjAreDNic01ndmN0aDd4cS9YbGdTSURyZnR4Y2EvRDRTUlZIWnNHTC84?=
 =?utf-8?B?SjNGaWhoaFZ0RDFRK1NRb0VPZEpHeVNQZFpZcjl6TmtsUml3OEpjdU54aHdW?=
 =?utf-8?B?Q2tXWFZtbEhJaW1ZQ3VtK0RKZlBqVENYYjlKNmc4R0YxV1pRZEhnWlkybC9v?=
 =?utf-8?B?ajJxdEdJZytucVF0SG43M2VpZ3JsNnhEcTBSWCtqbVVEWkJnbExBYVBKU1Zo?=
 =?utf-8?B?YmNxcGZiVWcydUI4TVRXc3hrYkRPOW9MT0xzbjBobmZoa083YTBVL3dHRDNS?=
 =?utf-8?B?UjhTNEJXemU4WHQzUEhSODFFK3lyc2R4aXpTOVc3cVFxam1SRWhPYnpjS3Zi?=
 =?utf-8?B?ODRSQitrMVJQRXJoQmxIMDBwMlVlMzRzUk5vVEV5S21jK1pjNmNCcVlNekFE?=
 =?utf-8?B?N2RVb052UHFkTUhLOE5Wc1BYMmw1bG90ZGxqWG1hVHFFYkh5Nno3eTVuZkZG?=
 =?utf-8?B?eDJZeGc5YWd1b0RQZVRKYmxnQldJb1Bjd1RhN29ISlh4bGZGbTVNc0M4UFI0?=
 =?utf-8?B?dkZLSi9uY2tmRkRZYlhvaDJzcTVmVnZHa0N0THd6eCt2RXQxeWhkVGt6cnRC?=
 =?utf-8?B?NW0xTnp2RjhkQkdjNUhaV0tWdVBsd0hHUVFJQTgyZTdzRE96MFdyV2VOcjlY?=
 =?utf-8?B?Tit2Nld0M2o5MTZKY2NuaWpRaThSbThBUnBEVnUrRUFSVzlqWW5VbWk5NEsy?=
 =?utf-8?B?WDlyR1lTM3UvazBkSTNpOHFzZHBTaDErOHlSRmVVWVRJSk5kRGd6VFRHVHVD?=
 =?utf-8?B?M2dMVEdSZ1E4c3NFN3ErcC9URExoc2lWMXBZQVlXQ1BBeTdZSDlDbTgydUJH?=
 =?utf-8?B?TTRxeVUyb2sxMkkyejRQV2hWZnJZNHZMYTdwYmFheUFnMnBoSkM3N3BQbDd2?=
 =?utf-8?B?NEZWYnZDby9MY0FkVmVWbjdJdzBNT1Q4KzE3K0lrclgrcWthUWtuUDIrSnBx?=
 =?utf-8?B?MXQvYlZKNGt6NXNBNVJjV25xYzJHK0Q3M2lzSGxTVmQ0RGdXRDhWTGtGK1do?=
 =?utf-8?B?WXdaV0EyRmZrSmlVQ0xrSEFYbGNTOFN0eXV5RWxuYXlrWTZUbTN1ZHQ5Wlp0?=
 =?utf-8?B?bHhERmZ5MHRJUXE1RnVHU2p5K3FTQUhGLytadXEyRkVSNE1LLzFYTEQyNUFt?=
 =?utf-8?B?ZEhVamlpSm5kQUFrOXZKSjNIWk45S09hZ1BiMHlYZzlRQkw0QWY5NmwrT043?=
 =?utf-8?B?bjN2ekkwbm5RaDlvVHdLUmNUUlNPZHNTbUEyczkxb0dSWVk5c0MwRUJValJB?=
 =?utf-8?B?V0Yxbkp0ejVLZ1RvQy9ncEFPU0UvYzk4UWlzUFo0RWp5cm55VEQ0cWNvUTF5?=
 =?utf-8?B?aXJVbnNZUEZrRU5kZG1TOHNNWEpWK3daZDhvSWZ5NU45bWY4OXduc3IzdG9U?=
 =?utf-8?B?YnFGcFdDa0ZoSzBXVmJ1VDhLSEdYeElHZ1hXcCtmTG9wNE1aQzFaT1V2OE51?=
 =?utf-8?B?dTh3MlJqUi9jaHZmMk10SXZROHNXSkZ1Y2cwM3lhamFTMGNldERERHNvcjdF?=
 =?utf-8?B?WGxrdkRVTzZDSXY3OU5ZbVpVNytOVmlaWjdyZzZ3REhPbkQ3QT09?=
X-Microsoft-Antispam-Message-Info: FNIRst+4n03LCP0EgI76V2qRVKY5XmEV97D4YANYsdEL6c6znEqj/FsmNND8PE2yOx3mWWj5QS7BC/6mIF7nrikqe6NLjPcw1bUJX49QlbO1miSNgn6iz0UygABwkGP6ckJsAwR6vPeWdXzRRaub3C/99CRVacqBWc69JL9loDmqxsPTIWa2ZthHYZyLTEQ9
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:2Hk+CO6o9W1TWawDI8A55CecNcKiKPYq/RjP7ue9grshfKiwviiysoteuGTMjiWmfb079mEmO1KdZb4saqk3ZyKtpeLmNvFKNiqbR1KOHDzohmj5l7TtWQO7StLrDISSb3cZnz+lYnzS2eGDRc9sn2FONgvhAhCcRP3Le0qyZbKA6ZmK4bIqrWVEyJZLFb0kPFWt7uw2YgWUIHO3Y+ENmCNovVV0F++7bRhqBEvex7KF/BOlA8wWfZL0YgQ0bwKEjTkLDGxo1Y0Xk2wcQ83CqmFxn5D7EzfNxCc74VLQse0NJ3SR8qnBSJy6/whuBBAZ2x7+6QLjY9gbn0mfGVrWMqkgKrv2GUfbsT6JQSDz1vtTncIr5HwRS6SPG2XbWjlzWXdFc0nT1A2v0Z+bZabeqYM/RQPh/HopacqfX/OSvEQAPtkw5P9y9et6vruoPwzi9N07LWVkUPNzVJeCT2p70Q==;5:jA2zkABVBHtKBaxpIn8MJLwiRUxRpwU2v1ZJE/4k8XlKEbjNOEMvN6H/OVdqv1PbaSLYg3mr5n9JOUN5rTGf6a4u+cscXyV4WqpLGRZJAxY0y/QrYaa+DbhmNy/HtN/eQzsTAjeAk8b7uFCCdqmO/Lveo73QmphuHPvo/t4nkkQ=;24:GzavP+UCK+xF5PtoDygtkh5Txp0bTiK+sFG6yLnZHCkPJY65XoH/4rDocuHgDmS7qCCZGX6T7EBcXO4r0DqZ9rYv4mea2GXdWLfwKMBN8Ek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;7:zkMJzCeYRC+FHfPTgdN4MQ+Po33d0e6O7I/9s7OWD/4zriBL3yp/Gt6DcQTOy7UD2F5VOS1+/dbOMeDwsDf+C0yGpixBKQmNSdw+wEgCpOPziK+ceqBBLOzciQREKvbfqsy0vAtXPlVt25YVyc3U0hdE0mHM0mssfIaq9iL3rN4VbOJJ2vJE6RAQkJXmoN3a9kc6TD+jpdaScATdLLpsJQ5MBbjsed3AoJMQ2uqVXqhs6PTw8IiS4K5wRF6gBkV9;20:TM/vxexi3+k7nbKHS2uBk8wOnwUP9sYgIV3oFqYt0j+e6n2IHErytswDL9bOPKXCOVdPkEDDrzWfaIB7iv+VKY0zNPxjvdc86RLZFklHyIFWlgk6i1QvwfQiOEhcCzyYtWPZ9ZOOG/sB+xi1Qtor1OA0r+bI8YlE2iew3cli/0c=
X-MS-Office365-Filtering-Correlation-Id: 7e440ea8-14e0-443e-407e-08d5a9dcd2be
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:13:41.9192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e440ea8-14e0-443e-407e-08d5a9dcd2be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598629638645342321?=
X-GMAIL-MSGID: =?utf-8?q?1598629638645342321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is just refactoring to allow next patches to have
lru pointer in memcg_drain_list_lru_node().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/list_lru.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index a92850bc209f..ed0f97b0c087 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -516,9 +516,10 @@ int memcg_update_all_list_lrus(int new_size)
 	goto out;
 }
 
-static void memcg_drain_list_lru_node(struct list_lru_node *nlru,
+static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 				      int src_idx, struct mem_cgroup *dst_memcg)
 {
+	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
 
@@ -547,7 +548,7 @@ static void memcg_drain_list_lru(struct list_lru *lru,
 		return;
 
 	for_each_node(i)
-		memcg_drain_list_lru_node(&lru->node[i], src_idx, dst_memcg);
+		memcg_drain_list_lru_node(lru, i, src_idx, dst_memcg);
 }
 
 void memcg_drain_all_list_lrus(int src_idx, struct mem_cgroup *dst_memcg)
