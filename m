Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936391AbeCBQSD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:18:03 -0500
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:42045
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934083AbeCBQR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:17:57 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org
Cc: babu.moger@amd.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/3] arch/x86/kvm: Introduce PLE(pause loop exit) logic in SVM
Date: Fri,  2 Mar 2018 11:17:33 -0500
Message-Id: <1520007456-85293-1-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR14CA0041.namprd14.prod.outlook.com (10.171.172.155) To
 BN6PR12MB1761.namprd12.prod.outlook.com (10.175.101.22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c893d669-8345-4d92-540f-08d580592841
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1761;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;3:X5vH/njUBzFbkqBBm2gur4Gdh7KCMAmg307l/zQ9O3/ywyn8+TguV+w13BIHSRcFn/wbLEueyqsbO5ZRJEUfs8LNsSz9SKzMHveTfDHWv5VO+yPtNcMQLolfQDlkm7NCTrWUPoQ7HEs1AF/2ibSgRJUL9SXYmNPBO2e6HrmWYbpwmy/M1H42o+jZJzMzgRh68raFib15nWmK03fJ3o4AzX+uJpADZ9a5/uHzAti30z6XN13h6TIU2Z9jylx/4SzO;25:XfR6dCkwlcKfX8iCC3qzwjE/ueEnYQkPJ+MIauMN5/CkiedcMV09fBTZ4jk1y1mgyxDUuysLk1CfrMdy9fFfpjkdVVJGpG1G4gE6loLHNFdbZonzrS+xPNXWF02sFBYq64Q/hfrBPGNDF3JtpvGOqt2TQ0EcXHT0Qp49rn9M+bva5g5lgUy7UsqUe3qL2ydBxxCpjAnU/0Ue3C4DPK9DYt/XmTVx//OfbaPc1R1waI5iCTBmuet68lxbV7nchjgdNkgQFSeQUDkUVFZQrZmr8ogb/ZUjeOQUnZKA/JFJeyxP9PFsoHFOCIHRLhVDpcRRZjMuAtCmvdo5Wb3l7NxThg==;31:719ETsPX2lNQlbeEfiJRijXcV6DLsUcivzGeJRoNDzQtRbtMj36cnlQrGDBeLx8/LnmGVLGUgZsXbroTNAzfi76d8iYT+MISBmZ5k7Fpk8jsmVmaZUqfDD8notmAZ89IV33Roww2yz8Xd8pFQRrgArISE2AaWxYB7rJsb/L8UBrEtIBBDnYSlj9piKBinlw5cfYbFO9BKWY3dAA0CXo3+I8Bymb9huIizsqLT776PBk=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1761:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;20:PQ+COnaHqHetpdPdRP8wkENgxdXir2AD7jrGXyUD2xBTsy1lg/l5R3Lfq6dE1reRaAGPzS4v3VSwvnNYX0S1yQ6UZqt7yc9ZuK4RaDxfYklsG5SQ2UxyCeBJZSlwAo+mmVh8ysCcAnh/ICGj8J1ib7WnGwt0OsWyQYcNEbCu2C8lN7yt6poJMvoZzC+EZW1LWRmZr+OQKAohu3B/tn9+koPKrr4CGa3/xN76NNj3pB6OaFFTUeWoC38gHFX7DXk23vvxG96omwpS485TAjajHsa2zkW5Zw2QLt22x2GYF44bLjxiBicWQv8b2Ax3K6LwMHbXcy3+U5S1PfBHpuoBL7rPIta/ZRB2kGrrfJxaKrloG3ejHArIxj2l9kOIn8IQnxQj6scfFwx1IXl0wPN5AsXlBGfa9kEyBRZfSyWEU2HjVa+Z8nvTy/U+jVwQw+J3q/t/TCl1mJveCD0H46/81r/f3/Q/OhqOy7P/m/yiQMWD/iD7k0fRjyWLx6YqMlpg;4:DZHJzyDcDcHb/RsblXT5PKsfU8nqa4C89ytBEKdPbX9HDj/JAefEotFixWtgty4M7bIdoAqU5q+uHHUz9KDftS6w7nRP7BoNQq07aT0U8Lglve4vN5hMT7wdamudmRz5g5qD35+kOPB4gb9CstFEpbNuxMj1AFXUVUD+rkAKI59fHcfEDfjXGe2265Fs7n1Q10yzMeBds0Aa9Y7FSRwDH75vxXHw2mmHe6+WFxuYTTtpyAn0v+5/W96ORRfMlbDaBCOrZx9YVjprW6razgnO5w==
X-Microsoft-Antispam-PRVS: <BN6PR12MB17611E03302098EB548DBE0C95C50@BN6PR12MB1761.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1761;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1761;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(51416003)(386003)(53936002)(186003)(26005)(7696005)(6486002)(52116002)(16526019)(68736007)(6666003)(4720700003)(106356001)(16586007)(316002)(8936002)(50226002)(4326008)(5660300001)(36756003)(81166006)(86362001)(48376002)(50466002)(81156014)(2906002)(7736002)(3846002)(66066001)(105586002)(305945005)(8676002)(53416004)(47776003)(97736004)(6116002)(478600001)(72206003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1761;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1761;23:B7UOZE2gcH0XAdJNEwoHPaxG1kq4vsMWcKl/qQrU4?=
 =?us-ascii?Q?WkO4GeCTz/3Nb2UQ1Uz1cqfksEptzLnvNsqiTgX26mNFnhReCHrFdCidTfMf?=
 =?us-ascii?Q?y0qAyjgZdhVZmrxNNTzQTkg9G9h3SXoPIaNsgS74s4xxOvB2rg3q8FrBLSc1?=
 =?us-ascii?Q?lKu6pxTS7yrQiaE0zh3UpyOVcdPoewtNX8FFNZxdJny/t+mNUBqi9PxasH56?=
 =?us-ascii?Q?yxWdJHp7VnFY3jvoQcKoCIaMoO+KmjzsrOZfIvpcxlBiT6uMBjtcj2N/zbm0?=
 =?us-ascii?Q?Veg5Crp9CEyU3rx/h6yXjv1kPeg3+bji36VGzfmcrEvI7VcL4rQyvqTW53Yv?=
 =?us-ascii?Q?M75LmrRlW029g09/sZtce2JjYFk2k6WvDD1MnMLFhXirMZlr1NktEGiBOZbv?=
 =?us-ascii?Q?wBaPAbu3Q/Da0vGZx6E6RUQIVRIZkdpySJtT2K3JYgyVq7cUNbkUkcf6EcfZ?=
 =?us-ascii?Q?xHwqZQDZ1h2+GxOjd2gYigc41WTGfEdqjw71Qso3TZBGbAuVGukUBeQkgl9f?=
 =?us-ascii?Q?UmSnFSmV9ra9OrBg4THkioAbHMol1SEi8GhImPsNba9M3LH1stlENRVS3pl5?=
 =?us-ascii?Q?buEcEqUz2NaOXNa988ENg/ooV4+gNehU5l3P2eSYY4DGDQ1D2lHBhRIwazEZ?=
 =?us-ascii?Q?gQJjIXG9fYX1+oxiP17/bcYt7QZf0Otve660MPfWRFdqb92APZf5GjFsW7fA?=
 =?us-ascii?Q?ykKaTQwvZ4VpAAOmjMPp7bKR1m5Z2O/Wc/gziPWYRu8CmJMJtunkdDGVafrU?=
 =?us-ascii?Q?9c1Mt1i022GNPgWDwJpBA71ium2hCkPNanz5yy3mLCWNAJqV2oojHRiFmrfg?=
 =?us-ascii?Q?hOJ+Mwnw1SFA3KwJsNW1GZai/odt8gQS+nks63BSwC4yP3useAa63x9798b9?=
 =?us-ascii?Q?2H1Em2LFNGBTHpKHYaumWALVc1etJcYGm4kXKp48+qEbXIY9yWeXcj1+0TGi?=
 =?us-ascii?Q?rVbTF8WsfTlFu5vKABL4AB2N+qqILfx/dElWOYGv869eXGpN+90Yln9zIQCs?=
 =?us-ascii?Q?g+S/GDHf2COHDT+e9k3ZDHOzcJSaxxnBKekb12iqRehV7FofYnkETj5tHVx1?=
 =?us-ascii?Q?+yPPm8jRwyRk7nzW0nEeM+u2h0L?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;6:5EWZ2ffVXFK0GcOgU3lCcWdzSv0M3ECz4FvWB2GlsFEIyDBdBMszT45jHjE0lrKPXa2ySfzfIlDzTZRTnTVTn9FOQFXmBoS25EhpK4YWph0bcL4w6IXCGU2XzADgOB82PCZlYDtjLpF7+7dt6h4PwClEWD5YJXLWJQFiyPjnXuvmluGZumpDNkHJn9M6gwwUjlE/G+7ZBU25E3/x60PM6yozI5pVXBS4CdoKyk4IPlYeD/9pWzyqKFWRu6i+4Y8KSe2kbAT8tgLf6KaEXlpEOvf6x387rhkrmXYVetb5WfHkDHeUIV1CBTO0BllgoPFnnlQEG/BZaubMkWwVKDhJON7shCcY7VFhziz0OCvjebc=;5:vy833lskjL89m6INKwdJmTF/c48Xk5xjcJELANLl4p5CdTfwu3iOWfzpCt+FZ5Ic5zR5aDJuBgux36MZKJ4SeP7BRo4Kjl01aBPGcyh4mGtiFgZt9kkaJ764wvTYiSz1JxqkwGYM11zHD30i7CylUa2vjyKZOUwIPlvo9nsw+YA=;24:ov3Xz6bbRsrkKbeKiWqPrLhhxy5GhKvmRn8d918soHnyOgKC4Y4TKWITtSJghkhQAAdv+gREMuktiA3csf3TnvtEgmuZ0qYkM8W2t80w+Y4=;7:wnNOnMSSp1zB7H79yoGNeoYJRJdbnnVWEpJSAwP3YrMEN4WVkMVWWgSG5ON3QK26Yv8vPucTTrVahCbiA6of4ONN32Mk6IMmrMFsN9/8tEJsz/S6R/uTmsuMNCJsOurlHxU//7OwqFa+nMi5CdsnQuu6EiXXKkQmxpya7sUhqjU+xIOduxqCk3n6UC4JD2vzlciPR4FTB6M8M+CSVBGnRRhPxy8eND2H3X6H33kURT7vJTo5X3GOcRc+9Lv0zCRG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1761;20:D/uPjpjeqZpuQs5RWNQvxwixqHMIAne7J2miCJFPKxes8S1HeThX+eAUz6tz86cEWHjVIbZMiQ1M/PmaZ4GFPnqp9DttbPD21Wr7PnH17aS6jx+5IumS6TLlTeVYuuS02wrtetS+7GqkqXj6Dz4z/rj60uuR8kAcwoM1kO7oEN3+VtkJan8/sdncLg8Sj/HDHT8e5Zlqkx4YKNyAWAsmszOv+9i9K9cI0ZvWPxUaK3IwNzywRSFErM+COAI7eRCT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 16:17:55.3443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c893d669-8345-4d92-540f-08d580592841
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1761
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Started working on bringing the PLE(pause loop exit) logic from VMX
to SVM. We noticed some improvements in certain cases where numerious
pause is generated.

Please take a look. If you have any suggestions to make things better,
let me know.

Babu Moger (3):
  arch/x86/kvm: SVM: Introduce pause filter threshold
  arch/x86/kvm: VMX: Bring the common code to header file
  arch/x86/kvm: SVM: Introduce pause loop exit logic in SVM

 arch/x86/include/asm/svm.h |   3 +-
 arch/x86/kvm/svm.c         | 116 ++++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx.c         |  53 ++++-----------------
 arch/x86/kvm/x86.h         |  35 ++++++++++++++
 4 files changed, 162 insertions(+), 45 deletions(-)

-- 
1.8.3.1
