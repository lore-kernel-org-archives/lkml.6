Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeDJOXt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:23:49 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56576 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753845AbeDJOXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:23:46 -0400
Date: Tue, 10 Apr 2018 17:22:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Colin King <colin.king@canonical.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: fix read of uninitialized data
Message-ID: <20180410142252.crnlqkia2pmucbum@mwanda>
References: <20180410134123.13832-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410134123.13832-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=324
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100142
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 02:41:23PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently function __load_ucode_amd can assign an uninitialized cp to *ret
> if get_builtin_microcode returns false.

What are you looking at?  Here is how it looks in linux-next:

   270  
   271          if (!get_builtin_microcode(&cp, x86_family(cpuid_1_eax)))
   272                  cp = find_microcode_in_initrd(path, use_pa);
   273  


If get_builtin_microcode() returns false, then cp is initialized on the
next line.

Maybe the issue is that cp.name is uninitialized.  It doesn't cause an
issue but it would be understandable for a static checker to warn about
it when we do "*ret = cp;".

regards,
dan carpenter
