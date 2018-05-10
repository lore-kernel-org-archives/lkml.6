Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757239AbeEJMNb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:13:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47244 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756891AbeEJMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:13:28 -0400
Date: Thu, 10 May 2018 13:12:56 +0100
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: fix oom_kill event handling
Message-ID: <20180510121251.GA6762@castle.DHCP.thefacebook.com>
References: <20180508124637.29984-1-guro@fb.com>
 <20180510114147.GB5325@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180510114147.GB5325@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:709b]
X-ClientProxiedBy: AM0PR06CA0043.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::20) To CO1PR15MB1079.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1079;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;3:QIjsbM/GW0FQbsLiQysVU/E5YtUrv2lFrv9kxzEP0lElLsToP5Ygy2GgR8r164NxTghSJCYY2p/U2RpQxNrmIS9xLlr6CfSzFGZOFZvv7Niz9wD3AK8J0u7f4RZFC7+FPLu8iVm9qww7SpHkRs3/i97KrpH9F39ioq85qMGmLLoGtVdxf6alPM3kuIwfVsGX8hHKXL2694O/9Z/R7R0WcW65kZ09xSAKtw0cNzJRDYaSvP0rM2PD4or7bDsj05r6;25:IuPxCsaaiFF5vu/k9w/PqdavNHjO+OXKtF5eMp85Q0t7SVbgm4aUdgrziJz+WWyM1c+wkMOhx5pjBHHCznYjyCV6upNlqkpBGDTvSwSfkhGzug+Z8UZ3ba001z6x5Dbsg4RQuOo/bXMJ/KHbdhtPSwmwcd9FuVN6kdwCIKMiaoPBbGTCtof36fvTbqOmLeBAzBJOPEvalDaUQfqFCbiYUQGFKoTaDerq+SIENaQYf2zXrJTSEIRgCoyLa2Au+EnMoiQfHyBV+nXS4ufM4w5WPXy3cIHiAfNvRarpfxxgTyfQ80GCYBU/kjYKnt1Ya0BhS59ilHYe6ygrYAKCPV2qbA==;31:+doNZ8OpBHkv8CMjSzRYwfW36oD/zoHKf2Y1HSoqFAczLgSqdh1+WQ3ZW6Ti53X2lNzi45CvduyiPny+irC6Ik0Qo1yT3i7rSOsstWfv/zRSg2Dzcp3PjhWjheFIbMKW0CmGooCxl6+TyQWG+Gxd6GYhjYAGZ6yOBZ4bVuHY4fro5vggpqAQhpHEtV33DD5K3iCgHuIabdBi68TITLpWRzX9XRO6DIvUZYXAgszLEKw=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1079:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;20:1TtvFoV8JMI2hsj2QTZkeO8r/EKKx9FPbkSkQQlvW60dFroZqneJDCZ7B3ojDBNUuW/YFATKqstjc380CW3EWVQuV14K6xmp6tZBMfSeuEfyOlZjKl/B6dkAxTIYgtOn0eVvLOsG2ilPKlV4Te+2jtYX0Tcp4WBtkN9fX0j+sU2QmQi+Wp09WHHuq6p4G9k+O8uCsnSox0DtkI3NDOlX5N+auCIz0idMCZ1IPxYAhuf1GpzWVf4UfCUTY6GEL/tP80wSkRIsF5r+v+lLv+RSZmCN6iSu1/GgX7HBUjqMFrNeZZ/ZHUc8ZxIfzg+igWW8cedeKXN14z/B9NOJiCl5lEOwcZJVihFZvxME+XcjoLEnwm6pgf05HKjVpfM1OzC/Gj+QVZxBjO2ziQjCrnjTfZUNMRAD5tC19el6D7KI1wellLz2cQ2fJmsN5xZglydryzLb2C4F2UFOjOIteJ2lN8IwtX/GuiOeQxWqHifehUHwSMe60sBtca+icxCUsurI;4:nQ8hEPQGvePhqg4H31yV8uYh4qgXl/uNQq0WOz7Sidq8+h6dHZ2gj/Glj27W8vXhgUWeEd2mJDq/PwyTf47g8NDAavpvdo59S4QfG50CK2jcMaywNZGqeD9/YOS0byp4XIsLALi6uXIL7nAp0TF62utDZ/9iW8AfjKFQ2Fj0vrl+3rWiAw9Sz5j6AgAjVGIvLHv12bel3d5/V59glibZ7XFB6IzNASXloAl7HXgQfbZV3ZfEIoQYXt081CTPkQprdUWDRHJTMFdgNFJqUK34hA==
X-Microsoft-Antispam-PRVS: <CO1PR15MB10795232A08170D27F5DA4AEBE980@CO1PR15MB1079.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1079;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1079;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39380400002)(39860400002)(346002)(377424004)(189003)(199004)(106356001)(105586002)(76176011)(486006)(476003)(5660300001)(6506007)(25786009)(386003)(7696005)(50466002)(16586007)(229853002)(316002)(52116002)(52396003)(4326008)(186003)(54906003)(478600001)(39060400002)(46003)(16526019)(58126008)(86362001)(6666003)(53936002)(55016002)(305945005)(9686003)(2906002)(7736002)(6916009)(47776003)(97736004)(6246003)(23726003)(8936002)(1076002)(6116002)(446003)(68736007)(81166006)(33656002)(11346002)(81156014)(8676002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1079;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1079;23:hfpOYJ1Bc41DgRgshJlW/xWChceErEWLMhnj+zrVL?=
 =?us-ascii?Q?7hDrTbtx88jHjlP7PvbvBm6pPWRbQ0zxIxBlgDzXNCMerCOA/kg8pVy0WUHH?=
 =?us-ascii?Q?7lYreGf+TzGWhfGUvSHtOeTO8M/6fZzVpQ486HETr1/ai8LcIAPNPUyrUHVC?=
 =?us-ascii?Q?+Zln1Qftv6h+pk1gX0E4opcQ9g2gKnuPAJJ55ZSzxG3kTomUIwSu7WZKg1yx?=
 =?us-ascii?Q?G6pJEKlDReeu7LUM1BWXGqclIfe5LnQiRS8gwFtOiIHspdikH0isKV2WQqB8?=
 =?us-ascii?Q?OOL8wgFgXhGQvFooFckZKZwfz8jwNoXIz/R0XJCprBNpm2O3ZHegrDHtAbE3?=
 =?us-ascii?Q?/Bnpf/hpJ4FYSSGeW5Xo0YRvfrYhSQ8kbn0p/K2VLCiLLWH+ENfIEFndmaLW?=
 =?us-ascii?Q?bhmupvL1j9hhdlv77SEdTaVRac4vDK6AUYhLpMVxdSnxvdb6nbiWhTyH95LG?=
 =?us-ascii?Q?N0i5bHIIZUdS9iZPXJC5UmdasOQvXszNZi5q8PehruD4+AVDk3XogSMI9fuH?=
 =?us-ascii?Q?+ijD1kerfw4KkRq0pM1q/bpM7qZ2l0kTy+SNtQOZ2otJ8Z5KLIidxj5DLDF8?=
 =?us-ascii?Q?CRNJSdI56QXucmTv99A8ho1wt4kzfzjRcH8G5rSwSW3AIrCxd5O5SsEoV1AY?=
 =?us-ascii?Q?s+ygP/89utPQxTkc+TnXfg4EmYkDvXlfD3NVMyimkNPvYvg+EqG1lX16BBdJ?=
 =?us-ascii?Q?WPS2fB2SE4foA9uZz7ygZCx1+Hb7WGv9LyivDVxXlpnLrPWoHD/fxFKIvzSE?=
 =?us-ascii?Q?NIbZDHoxiIt3VWTJevPUR6RLG4M0m6gqwssNjeWPEp9DVyoPBwKWsNQ/ggPC?=
 =?us-ascii?Q?pJDhEGyYPvBp9S3dONcjTy/pOhmtWh7Tl7uQQdR/7L0qUOJPuXFS/QWzJmwG?=
 =?us-ascii?Q?QNhGRtjGVQa71g8OrE/ADqfsXYVx25mHzoNDD2DWHUI0ueLmMsafTtpknn+V?=
 =?us-ascii?Q?2GZJzJjVnYXb/IMU7NlTb5OhN4cg7SCW1nuOAvNX03Vyg7vbpnl0IfViTa0z?=
 =?us-ascii?Q?bIgLo5bjvcFb7I2AFsvyyvRiHhSZ77YzFf4XgHDSZMkrG459V7cdk0xxkgSQ?=
 =?us-ascii?Q?sRLBqq2bRPm7HKeaWVE3GDwrxMwLSBGIc4rFpbqNipX2NKoM7AdlCVGBX/QK?=
 =?us-ascii?Q?QQ7KGCfjM16RRkakv0unnzsqnsUhG2/peTRt/IujuooB+XaI4Q7cVrIGCsxK?=
 =?us-ascii?Q?MSebGijCXEsT1asCV/XnGyKJza1zMdI23mZUVk750Apde0tSZAFGYuLc8/Bb?=
 =?us-ascii?Q?JNQ4VdDc8XZ4hRqbzFPyM75SuK5goVph3a4OdS00dpAoyjzzY6wv9JqvKS+V?=
 =?us-ascii?Q?lr+YxPsUjEZDQRzrSx7oZQ=3D?=
X-Microsoft-Antispam-Message-Info: KELuowCgHS+RPM4fZxY4+gKYVJnpN5Is0i3U35MsKMxLcF7WB/napfqtnPSjVS7C4vE3vqkC+pfaY2HYx7gT7Y9nSYMGDaC4AspGv/GovF0rR97kBVsG6BrLr1JD17WLQSsYglpz6j5kjDc6AiL008LLyWe/vPKbsNFmovFpX3apOhzPcEUey/NnX/itIJlR
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;6:zVz1YHvr9eSswANgg5NkvWEC0KB3NoQMFukU4IA40DOnGIFlDDQUe3Y3fkEKprP1hlC44VrQXPjHqTBg7kgO2n5HWExEiMK680geTc5BD2Lreq8jNP/vRU7RfUIYIyp0DR7K21fCxAMJUQIwDl0BXvY8ch/7eJREUDd74AQ+IBtEQvxhL92WN+unANJlJ1OATK8PdofZVW7KZwk2xKBToRNZanF3AkK5vCB8TTokBdfogRmtWs34O38TRCyHho+d1P9IlWTDT+G7mlXYXX2PjpxyoqGbgkXeUTTCbUzrUCQ1vss3nHy2tfrZFTgqr48TwAd06EyEoEkBNZ+11AXPfbGrNwcxZVfcgILKbUFxd0G7o4HgVXmcxu5eVmiMKpkhiP+TJlMYZBVyPOa3gYwHEoKw9PfT2wh4tOYRkdN9myrw3IOx2yAkYEt0LTPUMPfPPcXV/GMQ/ZZo60erK6S0kg==;5:FOrAcCyC2jzjyL96KLJfvUSyOYP5mqrqXwu9Y83wYXb1ZjRdLrmSufb3KIQ2KZFlDfMn518eWqQ8ywDuyq/75rfwzqPLNehn3VJ6VpJ1i3pQj+AIO8pxBVNngkLDUv96yc/In9etjWko8Y+wj52M410EvDKDsl7uSPHcZbhB2ig=;24:PezhBQUU6ylNXX347MfaQ9fzkXi2GTaSpIrJo+rRA3sK8XQJyiTsJE2KE7fbUo7v4xkqFp9GhSfH7rwq9VEIp+7/ITM9j7MXRyqCG2kA7oM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;7:B6xIq2698LOCFAb6D6at14vAD7YfptP8qONSBPq1oQ8y3HAuInLAFULm/iAO49bPKLsD8V7FrE20KSoKRwPyucukZsitvAD+/nW4nmvvMpRdpFhp0EN6klaGPccZ9cslg0mkz2yu911EOKYBHpdtW0K2LT+Jqm2MIu6nHGBXv2yRZvTLOs7jfEVCiP82e/VNARgxlW4aXDpg2cZ9r0hTcPXRtDi5eCfEZVKm/gVnfipyjFSVAPiGn9ieXh8wpEhe;20:QyT4sBsMQ+tgMwmeMpCjG5rLirJyhFiLJ2WMsKZ60OnLqVyYTjchma6M/Vrw+DWSkFH+HjJKOBVaNwXNJI1XKKIa9tX8xNjTzgYsLrtlaJsRagWGNn8RN6Tq3xj/Sd1t5QkdduWFuJzyI8EA7myVsgD/NrqrpVQ5L0lFhMkR01E=
X-MS-Office365-Filtering-Correlation-Id: 2077c989-73bc-447d-8ea4-08d5b66f657b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 12:13:08.3950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2077c989-73bc-447d-8ea4-08d5b66f657b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1079
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 01:41:47PM +0200, Michal Hocko wrote:
> On Tue 08-05-18 13:46:37, Roman Gushchin wrote:
> > Commit e27be240df53 ("mm: memcg: make sure memory.events is
> > uptodate when waking pollers") converted most of memcg event
> > counters to per-memcg atomics, which made them less confusing
> > for a user. The "oom_kill" counter remained untouched, so now
> > it behaves differently than other counters (including "oom").
> > This adds nothing but confusion.
> > 
> > Let's fix this by adding the MEMCG_OOM_KILL event, and follow
> > the MEMCG_OOM approach. This also removes a hack from
> > count_memcg_event_mm(), introduced earlier specially for the
> > OOM_KILL counter.
> 
> I agree that the current OOM_KILL is confusing. But do we really need
> another memcg_memory_event_mm helper used for only one counter rather
> than reuse memcg_memory_event. __oom_kill_process doesn't have the memcg
> but nothing should really prevent us from adding the context
> (oom_control) there, no?

Not sure, that I follow. oom_control has memcg pointer,
but it's a pointer to a cgroup, where OOM happened.
In particular, it's NULL for a system-wide OOM.

And we do send the OOM_KILL event to the cgroup,
which actually contains the process.
