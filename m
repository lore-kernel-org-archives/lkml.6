Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965128AbeEYOF6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:05:58 -0400
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:9568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964922AbeEYOF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:05:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xemul@virtuozzo.com;
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrei Vagin <avagin@virtuozzo.com>
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
 <0e1ce040-1beb-fd96-683c-1b18eb635fd6@virtuozzo.com>
 <20180524115613.GA16908@rapoport-lnx>
 <e42a383f-491a-b42a-347c-effe4b86b982@virtuozzo.com>
 <20180524190639.GD16908@rapoport-lnx>
From: Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <30794a36-ea91-c941-f59e-6545816a2265@virtuozzo.com>
Date: Fri, 25 May 2018 17:05:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180524190639.GD16908@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [83.220.239.148]
X-ClientProxiedBy: AM6PR0102CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::40) To AM0PR08MB2979.eurprd08.prod.outlook.com
 (2603:10a6:208:5b::24)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB2979;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB2979;3:lkfnbdJl+I6tldt7OIonZLrCRMzX+c8D7bc32tYEUVT/1fZXpqLXmpYLC4EECk4e6nr6uAEbeFtTqQi+W09RHFx5E+RCfXcMVKMQ43jhHX9TXlObMaHdhsBu/YQGYqSwytMbW78WNuPQnrQuC9+RhDZofIlPQTTOsYZUdmQXv9EdvzSNQhYi6zNQFq1YMySnu1Fvua/R4grBprh95J78b1580A1Ilc/q0NatePj3HVUps4HRWjDgXskXi6RWIZT3;25:ZByjSuDl1FF/pb6tVpLWIYBQJ8bE7GoMPDkmsLs899WnwMNgR5SuXMQoV0FhGJzDLoxT1f74m/03g1KCxy++PVVDIi03igybn6wfU3pR9UdxRjexKFdS0lz1VCu/RF7nDM5jcivyAdn4GNdcBiPKq7CKCXEnAtowuwMFYKg1r08OSGgSuf2cVGyIa00X3aHtILsdPz82Q5DR0W0byFo3sLlKzdykdMiz8pwxz//mRgczpZIOFlVhJuYrNNLenx0UpYBsIBtL36Ahq7pl9wGsvxFK9PEK+9OEZaxTLI0QR7tGV9OBMHbcyt0UDpy/1AC77ZjaYYunmCOc/IURcHq56g==;31:zy8xXiBB1zZfgFErHowHTOugj4uPnlYhn/PAPvzlAG6pdVSq+RneEIsGdfVygJzX2rnQeiYGtGb3qP5n9mYawitMuRrY7hWNpNUv/3BQfSOxfh7HkhOeGpSiLN/0NLsimZIDqpNU+dC0YJA0VFnVLKH3njHZYCgcGVcJ/g5+T6FBUm6o8ykaimpHq+XHeS5ZpYqjPB4aaZKGXzRMlLnmwMyzwt1MwZQE9PND2ZngY+E=
X-MS-TrafficTypeDiagnostic: AM0PR08MB2979:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB2979;20:jrm2OV+BwDNZZEq8wcmmjWDYkoO5KWL2Vb3mXY0VLmG645kvjijteFtK6N4/J1RsqgKfM8hyl964r05u5L9tSyRDtf1hnyQ86hgUs9sZ4AwNJ4vjY0YPd+QC4hVoSgLltwPNjYdd8XOzejwLy+KLmMzu6mIpYDVRxNiFiSodDgL0xhS1PmoJB0eI1rNRxgops1aGGq0J5ShAVSNO8tAXwh05xCLOeJXYEbIdNzvDHUed2EZJYLkzpGVEapTZNeHMOQftf6v5gBUrI80Ej7lxthPzJU78uoeUelLSnuBVs2k1peLQdoGnCNlNyETxFBeh3FxVYB30NtpHsVgmHrmMCZB7PuK2UbOF881j0AM9pD66JQAaEJb7VqJh8fiPTLbZuZzc20OGayEo2p6tJtijTuEU1pnKbaxpmLviy8i4XOciw57QjhKI1JE2G59DQf4ZID7e/sGrfsWyTbwVog6kJYsQuy8z5qCd2yyK0bYvtmtiFodw4mFc+njeoT324IPL;4:BBYoeDCsyV4AJ3DA1A+FE+kjwo8KrTDER9eFXyPzZHkFaNADkn5DywRszzW1Zvn4dxAW4BoXsQvzWfO5Z3/cCcxUPsnY0oiFeRDvU/R9UfND2fo7vZSk4Usa5kZsBGWtx6NPj+Bb328mE3EahdF4njgyiQ6+sE+dyOsxusMhjNFdfADq38gOM3AYeIXK/6VcVnE8oJHTpckS3rWw9wd9IMVafBJZsmjaheyKo5fmBvNyTWa5OneSeBew2hoFK7uwuOxLp9579GOdQ2gksbSEbw==
X-Microsoft-Antispam-PRVS: <AM0PR08MB2979C15D313492C5790EBDEBB0690@AM0PR08MB2979.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR08MB2979;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB2979;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39840400004)(396003)(39380400002)(366004)(189003)(199004)(486006)(105586002)(77096007)(66066001)(65806001)(76176011)(386003)(5660300001)(64126003)(65956001)(47776003)(6666003)(52116002)(31686004)(81156014)(97736004)(16526019)(106356001)(52146003)(23676004)(7736002)(50466002)(2486003)(68736007)(8936002)(65826007)(6916009)(117156002)(86362001)(81166006)(8676002)(31696002)(478600001)(26005)(3846002)(2616005)(956004)(36756003)(446003)(2906002)(6486002)(230700001)(11346002)(58126008)(53936002)(305945005)(93886005)(6116002)(107886003)(16576012)(4326008)(316002)(229853002)(6246003)(476003)(54906003)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR08MB2979;H:[192.168.43.234];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIyOTc5OzIzOjhmdWRyMUpidGVNWjgySWkwWXdZQXk3WXpy?=
 =?utf-8?B?LzFwckNUanNZR1BlV3V1OWlPM1RQTzRGQXJYL1dvd1lUNjRFVG9Cam5MZzhG?=
 =?utf-8?B?QUY0R2VsU2hWcHJxNGpqWmZ2ajB2YjU2YnRQd1FFWS9RcUFyR3Y1WWYvQlNC?=
 =?utf-8?B?V2d3OVo0YTVBdnpxWndocXdvZk1tZWYwL3MrZkJIMzVteVpydHIzcDNtVHcy?=
 =?utf-8?B?UzYvMnljRzFMV2NIOWRVeGNXSkxqUXNZS3I1WGc4TWsxUkJvR2VUOEhPaDJx?=
 =?utf-8?B?QTJBOGZSc2xVZGFVL3lyZFhNM0NLd1RMYk9mU2FKTy9LRW8rd2pWUUhQQjhx?=
 =?utf-8?B?dU5HZWNyL3RuMUtXYWRYamxEeXl6TDNPODlTQ3R2Sm9iRkdpQjlCV09RZlll?=
 =?utf-8?B?KzdqN3NYL3dDS01LSUF0dHBzdFI5Z0oremFPVURja2JmazdTR1YvNTZZbVFK?=
 =?utf-8?B?cjBrOGNLTkU1akhFM0ozZWtFL3llUGVIa1k2dTFDNEwyQWp0SFp0NC8wdEY1?=
 =?utf-8?B?YVJBeW96cWU5b2dyS3VqTFY1SWsvdGRDcmZzYUpZaGg3SCtrMVFVWDRmNk1h?=
 =?utf-8?B?N2VZd1ZMR2VENHFjT3JQS2NQc2ExUm5pVFZkNERhY1A1bU1PZE56a2wrNThZ?=
 =?utf-8?B?R28va0lMTjdsQWsxcGdmM0R0c1BVYUMwMUdORjRiNlJJUWJlQTZhNWN4MUYv?=
 =?utf-8?B?b1UwdXY5T0NZOXo3QUZFRVd5MjNaZDhsVUJhMjJma0FUUzlSQ1JEVlBZUWox?=
 =?utf-8?B?RnEvMXkrcW9Fa3JZWk1SRUpjVm9PZ2IzbU1JZk9GbjFEV3ZHN3hsaE8wUGhv?=
 =?utf-8?B?YWtNUmQ1dkZMeEpPbjdLVVRlSTM2aThTRHdkQnFQTmoyVW1Iak9xWWpuMUI1?=
 =?utf-8?B?L3gxN05nZ0xMdGdkZTZKc0VyNVMrOFEySjlvMStrOEN6RHBpcE9TMXVPeExt?=
 =?utf-8?B?YWFnbTFIb1JQTWIzTkpnR1gyT2hjbmhqYXJxc25WR29ncERtV3pnQ0xickIr?=
 =?utf-8?B?NFAxcitITno2VzZWeGFTV1ZkWlRJV1pQZTFqRUcwcVNkM0FTdjBTZHdkZk1B?=
 =?utf-8?B?L2RsT3FmZ1hnYzl1ZG5HcnlWdU8vMzZleklhQXNpV3F0NnVvSzhoT1RXVXBw?=
 =?utf-8?B?cUorS3lrTnd1OHpXTDFYdERFcFkrMnU2SVlxYWJ6N1FOZkgrb2Z6M3JKUEI2?=
 =?utf-8?B?VmZDc0lJeTdnV3drNkZUSDFWb2JyVmpPa0U1SGlnQ3FYQmRLZnhwQ2lXM09v?=
 =?utf-8?B?bHZFQXdFdy9FbzBpS1lob2lFeXYybVdEc1VSMGNrZnM1ajJWQy9EODA0akNu?=
 =?utf-8?B?VC9vWGVIMkdVWjlyTlRnZHFJQjNMV0pHQzRiUUtIMUpROHRORTBuQ0p5STNq?=
 =?utf-8?B?U09xMUVzZmpZQU9Ed1Z0YStKWEpBeVZMTHNhYnRXUHhGbzc5SFUvVGJPRzQ0?=
 =?utf-8?B?T0plOFRQcHk1bU56UVEzUVJiSXdkcVdRN1J5QUZDN1QvT2x2TUNTT1RvVk51?=
 =?utf-8?B?ZVpzaDBSTmlBZzlpY3pkQVpMaXByYWlESitzTTNjT0d0b1FVdWErNStPUXYy?=
 =?utf-8?B?S25RUkowN0R2TGVXenUxdlF1MUpLdGpGSXJYTTUvbE9sSnUyR0RCMk04aHlp?=
 =?utf-8?B?R3F3TkVYejJ4aVptNElHUG1abTBveUV4MER5TUU2emthbWdCbEkyeThuZi8v?=
 =?utf-8?B?WjNGSG9MMlYrN2ZZd29pcklEVzNQK3FhLy9hOXBGajM3c3F4dGgzcmxWT0g3?=
 =?utf-8?B?NCtvMDIrVXFYZjB5QWRlL29qWDhxQi9xb1FkeisxUVFVaWNPbGdCV1ZZcmM5?=
 =?utf-8?B?d3BGNWpScDJhS09yc2lsc2xUdUlKRDRwZGk0cmswYmZab3U0STN3U1VxRGg5?=
 =?utf-8?B?R2xCSGxTVC83QzNtSUI4bG91VG9nSG5vd2VxbS9vSWMxTXUrem5ieWJ6Z1dO?=
 =?utf-8?B?SzVYbklWbm9abjIrTGF5Y05VcnFvQjFLYXRrTWFyMXM5VWFITVJvMEkvYlFZ?=
 =?utf-8?B?RVlJT095Z0diRjZTa01PZ1pJMUFzc1ptaDBpUT09?=
X-Microsoft-Antispam-Message-Info: 9eh3nmbZ5HHbfidkh97qy2uoLkOXEQpLsauftVI7RAb2jtgW237j7A8dsu+4l+UFffDK2AOgoZLIsrsvCYbrPAIX4YI94Kj36fxQTQVGYc0K1rFjy/9k5Xw72AWrcPOHH11U47Iy6AsoUOqb4VKzi1Meocc2cGhmHfoLIiAgI2NLwVh/HI5zxBnljbAsXuTQ
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB2979;6:ZW9sCw77AqlAfD74TdZjGF/JquCSP/yQ6Pt/1yyYO5/lqN10pj+5IHO5eY+lhxqOnnYyrFo3vUGSUXMkVfK1J1YedeVqW/zm9MZyUrLXhHr+K+Bt5qdlQB4pyiFVeBeegIV/2qKiTtSCJL3TK4pDVCbIoWki0lQ73O7UoQR35mHGyzc1wM8WS8FYBi+p5WC2PAlgPpfTmQzePWQBQX7yQ7gdKzsQzrWLsEWwe7Rt8Nyw11Fdp7T0awAJ2PqHZV5V5zJvBfYzUOrS6EfZYVnW5Ej3Nt43FerJRXDG0TF67lzDsF8EROcLPMsYUmjECXJDnutoYJdlgoe9wyIUmgseNbuhG7cL2Umf07hApatqkFA2e21oSirBFpOFYDNLf27xbPqcDLKOt7zFYjdlThFWoVrDrvUNE3YePPZSg53DOmzpDCELlSOYwKois79mQMePxtLch4tNZGktF5I9nkeWzA==;5:12pP6dn5ntdLOWAQBKIBSt7AfIl6l3fkMQPIUonzJz495TSQoasFRY/rwE3FqP167LNPZt+UezXNmVq5nNn2yeSW9P/ZKbUqmE/7tOegVvqk7rkt6i1SrTP3pOF2wWgKQqOnJ8pKwr9dyxfltUjn6s3SBoDyU6fA8Ht4Q5dqeeg=;24:RsHHGIKF/Zq5VYZtbLHP2bTi5/KyXvEuOhzjM5ZjgtlIpOZYI1YYISgxh7TQ91iA6YF0Y9W2uYq/iv40aLCTDzhw219GYEckhYbmtNPudmU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB2979;7:vKzmSGQvOZPlrYFoPrs1tnmJJxh37cb0tBrAUFSu/8Vyop/NN9qz/FY20JeGpXpgsDSW/EQnad6BMhslYeFdYv4aO4+VVatrPbsfln7n7/1DU8KzSL4lwDiZJDuJvOtZx90eglTj1eEj5tg7MjfSo0BRUJNZHAGkZ7/ow/IJ71cNR4kwDjxP9lHc/G/oWxXpA/iAghc4GB/cOHyUUexI1WoE1Pmnq3U2zKj7vpBu+DQMJnAmIkhW/EcKxbr5dQtJ;20:IpjkuNB7CM/CYZMWsf+XnBxOmaEbEKj6ByuR3mZUQ0RxonokFtgD+zBO+w3vcI5nvoJk8HOUthbrmBU9nrBKZv1bOezsdqraaZA4Up/XGe+hwLq0u7jZeNp1Z7CRmQU6EX0kaPYlio6XjThjMNMTNgi6TMq6eBHI6RtOPO29/uo=
X-MS-Office365-Filtering-Correlation-Id: 9c85d7ab-5888-4147-d3b1-08d5c248a060
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 14:05:48.6927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c85d7ab-5888-4147-d3b1-08d5c248a060
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2979
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> But doesn't it race even with regular PF handling, not only the fork? How
>> do we handle this race?
> 
> With the regular #PF handing, the faulting thread patiently waits until
> page fault is resolved. With fork(), mremap() etc the thread that caused
> the event resumes once the uffd message is read by the monitor. That's
> surely way before monitor had chance to somehow process that message.

Ouch, yes. This is nasty :( So having no better solution in mind, let's
move forward with this.

Acked-by: Pavel Emelyanov <xemul@virtuozzo.com>
