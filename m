Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeEVTaB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:30:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58484 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeEVTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:30:00 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: Regression: Approximate 34% performance hit in receive throughput
 over ixgbe seen due to build_skb patch
From: William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <CAKgT0Ud2qriAkWcs56WEkw2vhYzBbWvzZOoY24ndsqPKaWn=Sg@mail.gmail.com>
Date: Tue, 22 May 2018 13:29:53 -0600
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "Duyck, Alexander H" <alexander.h.duyck@intel.com>
Message-Id: <4F646FBB-FE0B-4FEE-98E5-3CA2DF0598DE@oracle.com>
References: <A940030A-CDBF-41CD-816F-0BBC76E7C4F4@oracle.com>
 <CAKgT0Ud2qriAkWcs56WEkw2vhYzBbWvzZOoY24ndsqPKaWn=Sg@mail.gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
X-Mailer: Apple Mail (2.3445.8.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8901 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=570
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805220202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4MJU8Jj027665



> On May 22, 2018, at 12:23 PM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> 3. There should be a private flag that can be updated via "ethtool
> --set-priv-flags" called "legacy-rx" that you can enable that will
> roll back to the original that did the copy-break type approach for
> small packets and the headers of the frame.

With legacy-rx enabled, most of the regression goes away, but it's still present
as compared to the code without the patch; the regression then drops to about 6%:

# ethtool --show-priv-flags eno1
Private flags for eno1:
legacy-rx: on

Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65536      64   60.00     35934709      0     306.64
 65536           60.00     33791739            288.35

Socket  Message  Elapsed      Messages                
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

 65536      64   60.00     39254351      0     334.97
 65536           60.00     36761069            313.69

Is this variance to be expected, or do you think modification of the
interrupt delay would achieve better results?


    William Kucharski
