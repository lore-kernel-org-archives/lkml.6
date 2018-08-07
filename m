Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C105C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71462173F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RmZvE7Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71462173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390000AbeHGRwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:52:35 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com ([40.107.0.103]:23228
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733061AbeHGRwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZWbgfrXZk4tDjS2Z1ApZL2kNek79RZjPDTiGfD2smQ=;
 b=RmZvE7SifJencs/GRLjU9nlgwXWxlwOP2E73AeRFE7oNNeqUWaIIHwvnRhU9xymvvIuNRKXXvi6Pe9P1mj7ukM0ZMTEgTQvpdTiAAh4qL1isN1DVhcQfj9SW0a6caNz0jGO13pdogsFyUiFpfJnmkQV4ovwCuspULsnW5cIVwF8=
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2025.eurprd08.prod.outlook.com (2603:10a6:3:50::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.17; Tue, 7 Aug 2018 15:37:23 +0000
Subject: [PATCH RFC 00/10] Introduce lockless shrink_slab()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, ktkhai@virtuozzo.com,
        sfr@canb.auug.org.au, vdavydov.dev@gmail.com, mhocko@suse.com,
        chris@chris-wilson.co.uk, penguin-kernel@I-love.SAKURA.ne.jp,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 07 Aug 2018 18:37:19 +0300
Message-ID: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6P193CA0006.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::16)
 To HE1PR0801MB2025.eurprd08.prod.outlook.com (2603:10a6:3:50::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33310057-ae48-43c8-c963-08d5fc7baffd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2025;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;3:lhCuntUu50gnumQVvsFfMn04PEs27KyPtIZpZFtFk35MgJjCErxtrrrGlFmQ6SMmJpwZ4M6U63C8wVW9U9MAJ2+w7yA3iRuDKBlpeC+jgeagk/okkur1znID+GyYdNn7NeV5CcmKgg4b5OtrXjmepZAw2DHGbA+dQ+vebj0eJXLUwOPkv6w1ZfRP43/N79mAqmP4eQ8dpf4FGE8xFyeBsHe9u5xPzXLH/I+qttgvqWCCd2yhez+Z6+HwIo5ZXjhv;25:UwJfF+4yI2s8Sg/43FLjXbd+UDWC4P7wH1ORFMWDwjbHRYlXoH0O8QueDzg4EnRk1TBIk/bwjmfo9Au/Xk6oXWQq6lIyoyTgbKdGvPa8cjnLaBMwjSfNG/lZ0tTvlbL0EnlwR94hAFm0nl4gjYVk7Y9KKQZl8hxqqLJU5+Fa6LwHo1+ruXDo/lY4pHeuSSeZaPO/xn36ZWm0w8LeZD/sM8WY32QzpdLhWrD2dDX91aYkDVWTENg5S4l9flwVl0kjirGcHtzSv+re3sIW8e7FeQPHwxnWydoomNF3a9/2R7Nis0UXQTcXvUNgWvzZkydsRm1nOf3LZQvyT6GeeFFCmQ==;31:IUal/JZ5r5mr3JWjAkn69WAZSI6QF6e9w+8RQKUjPHL2fdU8cHciwvS8aToF9qbVgqNL1JESYrfCl09Mk/H8HJPH42lNrBqNBiVkgMKxTnzWnHYGpglp+4ktp+3NTHyjZ/MP0ehNESmYLS/0odS6x/5hyOkB7lDudgYiSz18WFwUZexK6JoXZfG2vDdMU9W9dpeJzQjsVTNlCZ/MBQHNkZIY1JAEcg1xduY8/AuIUDY=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2025:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:G2UNUL+yf3vIZKM1PbfcYj+XtNjGKc/COG3UNLq2IkBrYV0/P0NHXoadq+WTDtyI9RbCt6lUmjaCFUMG2MqkVPp4suMWNH1EKZu6ugnUf9F2AHUqkt3NGQGINIzPi+PtAcWq1sx1xSUP8f2znG8ZqWMe1dU4FrGbLUzRUL1DksDpd3HJ7oBQCoEDpy9cTdSG0cJopUwA99AZM9nc9j4lLmX33He+7flvrrgddHPZJvOiMG82PYzX5a75dXW/crB68jSTDNcHh2EWbioCWVtWw/wwmhCo0NT3q4VIkbS8bJ6pA1+jHgy9fqcr38WZvhUSItFcXfzU3maU1VPyRREuDNmkvWR66ielrBNvxCEKgVkUCDOG+tEr444U9qYtjy2mPAFFwxwYtHNUEl44U6MoWZlVxcWWFmYzGEAZLG2oEskKNdHwdQsh+QAQvhRq02NBpepODlc4j4EkeDDvJFdkraIV5rUcIuAte1Q1u6H1stgMgJW5bDKGrk2cfnBdoGYd;4:WtD2Qah3nwPjmqgT0OG17XnnLJBJt35RY+qIxqO8ZLpejsb8FNzeORVCDNXKOlGYsGQEq7IpiEPpc4/N2rX+MDE65P7KWO8bucCWf41rLyq+UrdcEJLZww0GdQZK3oj5+cmhj4quIxv2v1vkYpCor0Fyo93Vjk+lHsZJrDe3Jplf7z83oe2TVowobrbD1udV/7rot82G4pyHiB1j3czd8A6g6KSf5QCEjn8/Lp3lO3aYM7BT/Car5f4reiG6NZbG8FvbAloS4dlkeCBvpeDH0w==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB202515861A3BDF41FF3AD6D6CD270@HE1PR0801MB2025.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2025;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2025;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(39850400004)(396003)(366004)(346002)(376002)(199004)(189003)(8936002)(305945005)(81166006)(316002)(97736004)(8676002)(81156014)(66066001)(7406005)(7416002)(7736002)(47776003)(61506002)(2906002)(217873002)(14444005)(478600001)(486006)(956004)(476003)(58126008)(6666003)(68736007)(50466002)(86362001)(16526019)(7696005)(23676004)(2486003)(106356001)(39060400002)(6116002)(3846002)(186003)(26005)(9686003)(103116003)(33896004)(25786009)(966005)(386003)(105586002)(52116002)(55016002)(6506007)(6306002)(53936002)(5660300001)(230700001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2025;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjU7MjM6b0ZRZXgvamNxSDhHdDNkYjdXQjVza1ps?=
 =?utf-8?B?d3RzV1Y5YzdaKzh2WERSNGNXR09Za3VsdUpxRXVER0Y5MUhydlY5bEQweWZQ?=
 =?utf-8?B?ZFJIdUJTcC9XM1RHd25HbWIySkZhcVB1Q1FZZVkrdFlobnJEeS9scmNobG9B?=
 =?utf-8?B?YjhKTldvZy81amlaMzA2eFRWNmh6OWhsdjlDemJmc3l0UTRGSkdoU0FHWVM3?=
 =?utf-8?B?VnF3WGJDNHpFM2t0TUxLTTBZYlhWRzhSWkFyU3dBbGpSUkZWd01kWkZ6Q3or?=
 =?utf-8?B?ZENoSDdTVFhOb3QrMmp6RlpCZSs3SndIcUxQMHhjRDkwY3FqODFaKzR1WW1u?=
 =?utf-8?B?a3RyRmdNRWFuRk0wcUVRTUdzWWhKbDRFUFVGbmxINkpkSnVHTTI3ZExZOVVy?=
 =?utf-8?B?bTcvdlVMYm1EdkV6a0wwQk9UeXFueHZtTlVKSElxS2IrMGZLdmtMaVZ3UHB5?=
 =?utf-8?B?eEhuUmw1TG1YMG45REcvT2dqaXRZM3g2bThKYStjcDlud3BPYXVCbU9RRm9z?=
 =?utf-8?B?MVNlWmZUUmk1VWNPa0pBZG1LTE9iaTl4NHJpWnNacDhJbXhXUzVRL09xdlRx?=
 =?utf-8?B?Y0FSclJkM2xQNXdXMCtwNmVHMUhXb2R1Um9OT3FtckxZTmprQTJDMldXc2sr?=
 =?utf-8?B?Rk9oR0VET1llSTJrUkpKOTZ0eVFWN3JPT1FINHhOU2pxd3BWSCtoOGFWRFBj?=
 =?utf-8?B?VkdZTW1mUDFaRkNYdzVwbFJpK095QjYyTldlSWtXbVFEaWVRd1BDM0NDM2NP?=
 =?utf-8?B?cGU5eW5TaGNKTzg0K0dGTmdjZTJQV3ZqbTlCYWZ2T3g5L3VtZFpoVUd5MXVj?=
 =?utf-8?B?TEZnbm05MWdwRzNWL2ZiU0hpWlczaVJxZHF1MHlUS0VOYVhEUitwN2t0UHhU?=
 =?utf-8?B?N3ZaYkl3SklGa2tKdzl5aGFqaDVJS20zM2pISnNvdCtlc1F6bGZjeVhxNVJG?=
 =?utf-8?B?Z2ZCOUNjSU5xWXZFNlZHemtVMGVDeXJSaEk5N0E4dE5WeEM3cndzdmJIc0tm?=
 =?utf-8?B?L3NPT29KOVQzcDFxeW1OajlwQXAvWWQ3RWx1TGN6cCtuSWcrRTRtRTFCWVpF?=
 =?utf-8?B?OVBMOVVkNURkNU5ld0tpQS9pOFlsWXhoWHIxU2RGRUdkQkI4b2VacmwyRWxR?=
 =?utf-8?B?Y2pGWHBzOGVTSzVyVjk1aVZBRXBmcWxra24rejR1Ly9RVjlKZEVSTWdjaU9m?=
 =?utf-8?B?SFNwQVdEdVAvTko0bnd4T2FqUlIvY0gwR21sdmtoMWMwSjV1cEdSUUIxNXFM?=
 =?utf-8?B?ek9YT0dQejA3RGZGakFGNmd3bW9IbmpPMXQzRThLNmQybjNrUHA0emM3OU5P?=
 =?utf-8?B?ZWtRb1JmTUJaVEwzclVQZkZHTG91ZDhJblBVS283QW1PRVoxazJveFlwNzNK?=
 =?utf-8?B?T1pNbmRXVEp2N1B2Q1IyNE15TnVSZmR3Rmgxd3hEamxWWDhETWFSOUVZWW0w?=
 =?utf-8?B?Zlpzeisybk04aU0xWGViRUdpTXI4SWszZDRiTDZwcTNMUEx3Ry9HQUNwU0g4?=
 =?utf-8?B?MDVyR21Cek8vL0lYdEVCUkZKdkp5VVhlVVM0RlprNmJQQUsweHUzTm1VUFpk?=
 =?utf-8?B?N2NuT3BpNTNWZy9jU0RCMUVnUUU1YkFVY2lpU3VjdExtWnhESkthWTA2Ukxj?=
 =?utf-8?B?djVtNEFnSTgwdHRNVDE5NHJnTDVGbHJkUkN2dkVkYXhVK1VyYmtSWkQwQzUw?=
 =?utf-8?B?d0RISnlucHNWWUFVZjd0V2FsQ2tOZWl0TEtHT0crZ3Uyb0xxYTNyZHR2RUhB?=
 =?utf-8?Q?y/i4wJIXqOj3jEwyfZnz6SixSlH7vzvIYws6Tqc=3D?=
X-Microsoft-Antispam-Message-Info: cDOWn3nMk06wt8TDltglKxZiI9bW9AXCnsm9PhMP0RyxTPbrQ7wUNJ2OAKVKmRQMa6YLeM/7uPV/q1vFBkLFDHYS8pMHRhpJWok1VbQFFZfqXPb4NUdve2lQGBpAZ7bxRSIKIMTjK+FAgTtuvTg4FV0oVkyHJjWAk0K/4hgCmXJEn9F1Ef3pzVNDXOeCEBIMJhxa2Z/npHdlZc8rSdtiKjzcbPl0YfBGHpZUJZLGgPzQag7QQ9xSgvDsOjms8ECepni6q/FIuTOdqpCZkXIGHOvY1Z6rZ0JrMvXDV0Hm0+RbY0HXGEdXo5f3rK9cY4IRZaG17blm0aHkca1HciYfWyfqvQ3/VR9PCP+w3NVWwyI=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;6:QUWWfquMx0L/m/UW4xJhi3RfxghpcZCQzPBB3KkuuEcdwADRMfDD1+0N8O/AXq/iCLCSSihyzSWnlcv3QY9HwJ1oSLJJIlCp7mnxPqeJE2Et6q5mOFQuAXPUEPEE/WzQq2LB6Q0HW7yVjZpgyBttokovMOQ9vyVwawHVECQWYCFjxIEkFlQVfBIasAAGyoj3mNi0Sa+mFAS2BNB29zQQRC6+jFmNbgQWf7t6Lf+X3B4amuhCa4vFmaJoBE3FBajrZJOV5y/k2mNPiabh2vuOMSYDQPN1Zfb95//78q3RKpYfXQqfwZP1W9bcKuIq49OqkWimcRS55RI6fJfp03ZP/E0474uvxquQgy/Q94A+3xOyk20opoNVidDIiNpkZQW6qGoh/nmUYbMIK3QLAJr1fytPkSHHfv0abslKDjUD43jEsfrkr2Rac2ku8YsaxkihH93po53qmfg9PNWTWjBmug==;5:JpmlitvYuDCYqAu0icqAZkruHfzYdRtDXrORZuYKZL4GY1FY15KQBYHRZXMOpzefHUkBb9TIrfXuqwlaAH9kdzq18tBAgJL7XPRSPAoQXGZyUTPlQrfwXCqOcNancsqh/HIjgXAK4fdTjvieL1LywNzdLAc0HUeNdINSxriRFSs=;7:usl0Z7KfA+Heq/05n/IzyN7rlA57+fWn66/vehFMVE3FivUuKpis/zeayMbSS8Oc6DdCOPCrQTTpMJWALy/vxOB532Y1MWb5bs6cIVArEyb1TJYwUQgQQ686E2vgTUp65ovEANGEEmDHoJN5bniwRjd98qhVUbrKuXcr16icaVoA5UlJJ4l0fpdLQ+1Ir+l6nRhDT3iEl/CxdDc/NaZuA2mn2SGRGz/VzuoZCcwdcsMnz0eJ+DePT3quCbocnlzB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:QjX4kbynVcbBmdcJDUulQaRCcQKuAx3Jf/OCaNdoqvr2JnUqbJ3dgqHqY+pCH7GPQLSV92YHbYGiAiknabMpSBAcDZzE/bdQG0blmP2L0o91rkgSQq8yGMk4x7+ss+mHq30ncnmfDCyhtkyCvdo1gANCUPXdyzq0AAq7VVLTsN8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:37:23.9588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33310057-ae48-43c8-c963-08d5fc7baffd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After bitmaps of not-empty memcg shrinkers were implemented
(see "[PATCH v9 00/17] Improve shrink_slab() scalability..."
series, which is already in mm tree), all the evil in perf
trace has moved from shrink_slab() to down_read_trylock().
As reported by Shakeel Butt:

     > I created 255 memcgs, 255 ext4 mounts and made each memcg create a
     > file containing few KiBs on corresponding mount. Then in a separate
     > memcg of 200 MiB limit ran a fork-bomb.
     >
     > I ran the "perf record -ag -- sleep 60" and below are the results:
     > +  47.49%            fb.sh  [kernel.kallsyms]    [k] down_read_trylock
     > +  30.72%            fb.sh  [kernel.kallsyms]    [k] up_read
     > +   9.51%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_iter
     > +   1.69%            fb.sh  [kernel.kallsyms]    [k] shrink_node_memcg
     > +   1.35%            fb.sh  [kernel.kallsyms]    [k] mem_cgroup_protected
     > +   1.05%            fb.sh  [kernel.kallsyms]    [k] queued_spin_lock_slowpath
     > +   0.85%            fb.sh  [kernel.kallsyms]    [k] _raw_spin_lock
     > +   0.78%            fb.sh  [kernel.kallsyms]    [k] lruvec_lru_size
     > +   0.57%            fb.sh  [kernel.kallsyms]    [k] shrink_node
     > +   0.54%            fb.sh  [kernel.kallsyms]    [k] queue_work_on
     > +   0.46%            fb.sh  [kernel.kallsyms]    [k] shrink_slab_memcg

The patchset continues to improve shrink_slab() scalability and makes
it lockless completely. Here are several steps for that:

1)Use SRCU to synchronize shrink_slab() and unregister_shrinker().
  Nothing exiting is here, just srcu_read_lock() in shrink_slab()
  and shrink_slab_memcg() and synchronize_srcu() in unregister_shrinker().
  See [2/10] for details.
2)The above requires to make SRCU unconditional enabled.
  [1/10] makes this. Note, that if we can't always enable
  SRCU, we may use percpu_rw_semaphore instead of this.
  See comment to [2/10] for details.
3)Convert shrinker_rwsem to mutex. Just cleanup.

4)Further patches make possible to speed up unregister_shrinker()
  by splitting it in two stages. The first stage unlinks shrinker
  from shrinker_list and shrinker_idr, while the second finalizes
  the thing by calling synchronize_srcu() and freeing memory.
  Patch [4/10] actually splits unregister_shrinker(), while
  [10/10] makes superblock shrinker to use the new helpers
  (unregister_shrinker_delayed_{initiate,finalize}().

5)Patches [5-9/10] are preparations on fs, which make possible
  to split superblock unregistration in two stages. They sequentially
  make super_cache_count() and super_cache_scan() safe to be called
  on unregistering shrinker:

  [cpu0]                                           [cpu1]
  unregister_shrinker_delayed_initiate(shrinker)
  ...                                              shrink_slab(shrinker) (OK!)
  unregister_shrinker_delayed_finalize(shrinker)

After all of this, shrink_slab() becomes lockless, while unregister_shrinker()
remains fast at least for superblock shrinker (another shrinkers also
can be made to unregister in the same delayed manner).

(This requires "mm: Use special value SHRINKER_REGISTERING instead list_empty() check"
 from https://lkml.org/lkml/2018/8/6/276, which is on the way to -mm tree, as said
 by -mm tree notification message from Andrew).

---

Kirill Tkhai (10):
      rcu: Make CONFIG_SRCU unconditionally enabled
      mm: Make shrink_slab() lockless
      mm: Convert shrinker_rwsem to mutex
      mm: Split unregister_shrinker()
      fs: Move list_lru_destroy() to destroy_super_work()
      fs: Shrink only (SB_ACTIVE|SB_BORN) superblocks in super_cache_scan()
      fs: Introduce struct super_operations::destroy_super() callback.
      xfs: Introduce xfs_fs_destroy_super()
      shmem: Implement shmem_destroy_super()
      fs: Use unregister_shrinker_delayed_{initiate,finalize} for super_block shrinker


 drivers/base/core.c                                |   42 ----------
 fs/super.c                                         |   32 ++++----
 fs/xfs/xfs_super.c                                 |   14 +++
 include/linux/device.h                             |    2 
 include/linux/fs.h                                 |    6 +
 include/linux/rcutiny.h                            |    4 -
 include/linux/shrinker.h                           |    2 
 include/linux/srcu.h                               |    5 -
 kernel/notifier.c                                  |    3 -
 kernel/rcu/Kconfig                                 |   12 ---
 kernel/rcu/tree.h                                  |    5 -
 kernel/rcu/update.c                                |    4 -
 mm/shmem.c                                         |    8 ++
 mm/vmscan.c                                        |   82 ++++++++++----------
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |    5 -
 15 files changed, 89 insertions(+), 137 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
