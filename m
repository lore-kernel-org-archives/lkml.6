Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ED5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390A620842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfBLPuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:50:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:24287 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbfBLPuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:50:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 07:50:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="gz'50?scan'50,208,50";a="299158253"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 12 Feb 2019 07:50:12 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gtaK2-0006IG-W3; Tue, 12 Feb 2019 23:50:11 +0800
Date:   Tue, 12 Feb 2019 23:49:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     kbuild-all@01.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] elf: use list_for_each_entry()
Message-ID: <201902122314.5Z57Au0r%fengguang.wu@intel.com>
References: <20190204202800.GB27482@avx2>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190204202800.GB27482@avx2>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexey,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.0-rc4]
[cannot apply to next-20190212]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexey-Dobriyan/elf-don-t-be-afraid-of-overflow/20190205-225931
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 6.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=6.4.0 make.cross ARCH=nds32 

All errors (new ones prefixed by >>):

   fs/binfmt_elf.c: In function 'write_note_info':
>> fs/binfmt_elf.c:2124:19: error: 'tmp' undeclared (first use in this function)
      for (i = 0; i < tmp->num_notes; i++)
                      ^~~
   fs/binfmt_elf.c:2124:19: note: each undeclared identifier is reported only once for each function it appears in

vim +/tmp +2124 fs/binfmt_elf.c

3aba481f Roland McGrath  2008-01-30  2111  
3aba481f Roland McGrath  2008-01-30  2112  static int write_note_info(struct elf_note_info *info,
ecc8c772 Al Viro         2013-10-05  2113  			   struct coredump_params *cprm)
3aba481f Roland McGrath  2008-01-30  2114  {
1e0d184d Alexey Dobriyan 2019-02-04  2115  	struct elf_thread_status *ets;
3aba481f Roland McGrath  2008-01-30  2116  	int i;
3aba481f Roland McGrath  2008-01-30  2117  
3aba481f Roland McGrath  2008-01-30  2118  	for (i = 0; i < info->numnote; i++)
ecc8c772 Al Viro         2013-10-05  2119  		if (!writenote(info->notes + i, cprm))
3aba481f Roland McGrath  2008-01-30  2120  			return 0;
3aba481f Roland McGrath  2008-01-30  2121  
3aba481f Roland McGrath  2008-01-30  2122  	/* write out the thread status notes section */
1e0d184d Alexey Dobriyan 2019-02-04  2123  	list_for_each_entry(ets, &info->thread_list, list) {
3aba481f Roland McGrath  2008-01-30 @2124  		for (i = 0; i < tmp->num_notes; i++)
ecc8c772 Al Viro         2013-10-05  2125  			if (!writenote(&tmp->notes[i], cprm))
3aba481f Roland McGrath  2008-01-30  2126  				return 0;
3aba481f Roland McGrath  2008-01-30  2127  	}
3aba481f Roland McGrath  2008-01-30  2128  
3aba481f Roland McGrath  2008-01-30  2129  	return 1;
3aba481f Roland McGrath  2008-01-30  2130  }
3aba481f Roland McGrath  2008-01-30  2131  

:::::: The code at line 2124 was first introduced by commit
:::::: 3aba481fc94d83ff630d4b7cd2f7447010c4c6df elf core dump: notes reorg

:::::: TO: Roland McGrath <roland@redhat.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--RnlQjJ0d97Da+TV1--
