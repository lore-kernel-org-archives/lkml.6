Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487EFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAF324AA0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAF324AA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932100AbeGCCGH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:06:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:5720 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeGCCGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:06:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 19:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,301,1526367600"; 
   d="gz'50?scan'50,208,50";a="242149339"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2018 19:05:57 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1faAha-000KNI-0c; Tue, 03 Jul 2018 10:05:58 +0800
Date:   Tue, 3 Jul 2018 10:05:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     kbuild-all@01.org, peterz@infradead.org, acme@kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, will.deacon@arm.com,
        mark.rutland@arm.com, jolsa@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        mathieu.poirier@linaro.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] perf/aux: Make perf_event accessible to setup_aux()
Message-ID: <201807030918.9GVhQmQf%fengguang.wu@intel.com>
References: <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mathieu,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mathieu-Poirier/perf-Add-ioctl-for-PMU-driver-configuration/20180703-064327
config: s390-defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=s390 

All error/warnings (new ones prefixed by >>):

>> arch/s390/kernel/perf_cpum_sf.c:1606:1: error: expected identifier or '(' before '{' token
    {
    ^
>> arch/s390/kernel/perf_cpum_sf.c:1604:14: warning: 'aux_buffer_setup' used but never defined
    static void *aux_buffer_setup(struct perf_event *event, void **pages,
                 ^~~~~~~~~~~~~~~~

vim +1606 arch/s390/kernel/perf_cpum_sf.c

ca5955cd Pu Hou          2016-11-11  1589  
ca5955cd Pu Hou          2016-11-11  1590  /*
ca5955cd Pu Hou          2016-11-11  1591   * aux_buffer_setup() - Setup AUX buffer for diagnostic mode sampling
ca5955cd Pu Hou          2016-11-11  1592   * @cpu:	On which to allocate, -1 means current
ca5955cd Pu Hou          2016-11-11  1593   * @pages:	Array of pointers to buffer pages passed from perf core
ca5955cd Pu Hou          2016-11-11  1594   * @nr_pages:	Total pages
ca5955cd Pu Hou          2016-11-11  1595   * @snapshot:	Flag for snapshot mode
ca5955cd Pu Hou          2016-11-11  1596   *
ca5955cd Pu Hou          2016-11-11  1597   * This is the callback when setup an event using AUX buffer. Perf tool can
ca5955cd Pu Hou          2016-11-11  1598   * trigger this by an additional mmap() call on the event. Unlike the buffer
ca5955cd Pu Hou          2016-11-11  1599   * for basic samples, AUX buffer belongs to the event. It is scheduled with
ca5955cd Pu Hou          2016-11-11  1600   * the task among online cpus when it is a per-thread event.
ca5955cd Pu Hou          2016-11-11  1601   *
ca5955cd Pu Hou          2016-11-11  1602   * Return the private AUX buffer structure if success or NULL if fails.
ca5955cd Pu Hou          2016-11-11  1603   */
ceb39bf0 Mathieu Poirier 2018-07-02 @1604  static void *aux_buffer_setup(struct perf_event *event, void **pages,
ceb39bf0 Mathieu Poirier 2018-07-02  1605  			      int nr_pages, bool snapshot);
ca5955cd Pu Hou          2016-11-11 @1606  {
ca5955cd Pu Hou          2016-11-11  1607  	struct sf_buffer *sfb;
ca5955cd Pu Hou          2016-11-11  1608  	struct aux_buffer *aux;
ca5955cd Pu Hou          2016-11-11  1609  	unsigned long *new, *tail;
ca5955cd Pu Hou          2016-11-11  1610  	int i, n_sdbt;
ca5955cd Pu Hou          2016-11-11  1611  
ca5955cd Pu Hou          2016-11-11  1612  	if (!nr_pages || !pages)
ca5955cd Pu Hou          2016-11-11  1613  		return NULL;
ca5955cd Pu Hou          2016-11-11  1614  
ca5955cd Pu Hou          2016-11-11  1615  	if (nr_pages > CPUM_SF_MAX_SDB * CPUM_SF_SDB_DIAG_FACTOR) {
ca5955cd Pu Hou          2016-11-11  1616  		pr_err("AUX buffer size (%i pages) is larger than the "
ca5955cd Pu Hou          2016-11-11  1617  		       "maximum sampling buffer limit\n",
ca5955cd Pu Hou          2016-11-11  1618  		       nr_pages);
ca5955cd Pu Hou          2016-11-11  1619  		return NULL;
ca5955cd Pu Hou          2016-11-11  1620  	} else if (nr_pages < CPUM_SF_MIN_SDB * CPUM_SF_SDB_DIAG_FACTOR) {
ca5955cd Pu Hou          2016-11-11  1621  		pr_err("AUX buffer size (%i pages) is less than the "
ca5955cd Pu Hou          2016-11-11  1622  		       "minimum sampling buffer limit\n",
ca5955cd Pu Hou          2016-11-11  1623  		       nr_pages);
ca5955cd Pu Hou          2016-11-11  1624  		return NULL;
ca5955cd Pu Hou          2016-11-11  1625  	}
ca5955cd Pu Hou          2016-11-11  1626  
ca5955cd Pu Hou          2016-11-11  1627  	/* Allocate aux_buffer struct for the event */
ca5955cd Pu Hou          2016-11-11  1628  	aux = kmalloc(sizeof(struct aux_buffer), GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1629  	if (!aux)
ca5955cd Pu Hou          2016-11-11  1630  		goto no_aux;
ca5955cd Pu Hou          2016-11-11  1631  	sfb = &aux->sfb;
ca5955cd Pu Hou          2016-11-11  1632  
ca5955cd Pu Hou          2016-11-11  1633  	/* Allocate sdbt_index for fast reference */
ca5955cd Pu Hou          2016-11-11  1634  	n_sdbt = (nr_pages + CPUM_SF_SDB_PER_TABLE - 1) / CPUM_SF_SDB_PER_TABLE;
ca5955cd Pu Hou          2016-11-11  1635  	aux->sdbt_index = kmalloc_array(n_sdbt, sizeof(void *), GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1636  	if (!aux->sdbt_index)
ca5955cd Pu Hou          2016-11-11  1637  		goto no_sdbt_index;
ca5955cd Pu Hou          2016-11-11  1638  
ca5955cd Pu Hou          2016-11-11  1639  	/* Allocate sdb_index for fast reference */
ca5955cd Pu Hou          2016-11-11  1640  	aux->sdb_index = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1641  	if (!aux->sdb_index)
ca5955cd Pu Hou          2016-11-11  1642  		goto no_sdb_index;
ca5955cd Pu Hou          2016-11-11  1643  
ca5955cd Pu Hou          2016-11-11  1644  	/* Allocate the first SDBT */
ca5955cd Pu Hou          2016-11-11  1645  	sfb->num_sdbt = 0;
ca5955cd Pu Hou          2016-11-11  1646  	sfb->sdbt = (unsigned long *) get_zeroed_page(GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1647  	if (!sfb->sdbt)
ca5955cd Pu Hou          2016-11-11  1648  		goto no_sdbt;
ca5955cd Pu Hou          2016-11-11  1649  	aux->sdbt_index[sfb->num_sdbt++] = (unsigned long)sfb->sdbt;
ca5955cd Pu Hou          2016-11-11  1650  	tail = sfb->tail = sfb->sdbt;
ca5955cd Pu Hou          2016-11-11  1651  
ca5955cd Pu Hou          2016-11-11  1652  	/*
ca5955cd Pu Hou          2016-11-11  1653  	 * Link the provided pages of AUX buffer to SDBT.
ca5955cd Pu Hou          2016-11-11  1654  	 * Allocate SDBT if needed.
ca5955cd Pu Hou          2016-11-11  1655  	 */
ca5955cd Pu Hou          2016-11-11  1656  	for (i = 0; i < nr_pages; i++, tail++) {
ca5955cd Pu Hou          2016-11-11  1657  		if (require_table_link(tail)) {
ca5955cd Pu Hou          2016-11-11  1658  			new = (unsigned long *) get_zeroed_page(GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1659  			if (!new)
ca5955cd Pu Hou          2016-11-11  1660  				goto no_sdbt;
ca5955cd Pu Hou          2016-11-11  1661  			aux->sdbt_index[sfb->num_sdbt++] = (unsigned long)new;
ca5955cd Pu Hou          2016-11-11  1662  			/* Link current page to tail of chain */
ca5955cd Pu Hou          2016-11-11  1663  			*tail = (unsigned long)(void *) new + 1;
ca5955cd Pu Hou          2016-11-11  1664  			tail = new;
ca5955cd Pu Hou          2016-11-11  1665  		}
ca5955cd Pu Hou          2016-11-11  1666  		/* Tail is the entry in a SDBT */
ca5955cd Pu Hou          2016-11-11  1667  		*tail = (unsigned long)pages[i];
ca5955cd Pu Hou          2016-11-11  1668  		aux->sdb_index[i] = (unsigned long)pages[i];
ca5955cd Pu Hou          2016-11-11  1669  	}
ca5955cd Pu Hou          2016-11-11  1670  	sfb->num_sdb = nr_pages;
ca5955cd Pu Hou          2016-11-11  1671  
ca5955cd Pu Hou          2016-11-11  1672  	/* Link the last entry in the SDBT to the first SDBT */
ca5955cd Pu Hou          2016-11-11  1673  	*tail = (unsigned long) sfb->sdbt + 1;
ca5955cd Pu Hou          2016-11-11  1674  	sfb->tail = tail;
ca5955cd Pu Hou          2016-11-11  1675  
ca5955cd Pu Hou          2016-11-11  1676  	/*
ca5955cd Pu Hou          2016-11-11  1677  	 * Initial all SDBs are zeroed. Mark it as empty.
ca5955cd Pu Hou          2016-11-11  1678  	 * So there is no need to clear the full indicator
ca5955cd Pu Hou          2016-11-11  1679  	 * when this event is first added.
ca5955cd Pu Hou          2016-11-11  1680  	 */
ca5955cd Pu Hou          2016-11-11  1681  	aux->empty_mark = sfb->num_sdb - 1;
ca5955cd Pu Hou          2016-11-11  1682  
ca5955cd Pu Hou          2016-11-11  1683  	debug_sprintf_event(sfdbg, 4, "aux_buffer_setup: setup %lu SDBTs"
ca5955cd Pu Hou          2016-11-11  1684  			    " and %lu SDBs\n",
ca5955cd Pu Hou          2016-11-11  1685  			    sfb->num_sdbt, sfb->num_sdb);
ca5955cd Pu Hou          2016-11-11  1686  
ca5955cd Pu Hou          2016-11-11  1687  	return aux;
ca5955cd Pu Hou          2016-11-11  1688  
ca5955cd Pu Hou          2016-11-11  1689  no_sdbt:
ca5955cd Pu Hou          2016-11-11  1690  	/* SDBs (AUX buffer pages) are freed by caller */
ca5955cd Pu Hou          2016-11-11  1691  	for (i = 0; i < sfb->num_sdbt; i++)
ca5955cd Pu Hou          2016-11-11  1692  		free_page(aux->sdbt_index[i]);
ca5955cd Pu Hou          2016-11-11  1693  	kfree(aux->sdb_index);
ca5955cd Pu Hou          2016-11-11  1694  no_sdb_index:
ca5955cd Pu Hou          2016-11-11  1695  	kfree(aux->sdbt_index);
ca5955cd Pu Hou          2016-11-11  1696  no_sdbt_index:
ca5955cd Pu Hou          2016-11-11  1697  	kfree(aux);
ca5955cd Pu Hou          2016-11-11  1698  no_aux:
ca5955cd Pu Hou          2016-11-11  1699  	return NULL;
ca5955cd Pu Hou          2016-11-11  1700  }
ca5955cd Pu Hou          2016-11-11  1701  

:::::: The code at line 1606 was first introduced by commit
:::::: ca5955cdeae744edd3dcc65d677e833fc29658c2 s390/cpumf: introduce AUX buffer for dump diagnostic sample data

:::::: TO: Pu Hou <bjhoupu@linux.vnet.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ZPt4rx8FFjLCG7dd--
