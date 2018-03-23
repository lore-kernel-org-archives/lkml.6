Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeCWCvW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 22:51:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:22735 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751747AbeCWCvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 22:51:21 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,348,1517904000";
   d="gz'50?scan'50,208,50";a="214110830"
Date: Fri, 23 Mar 2018 10:51:09 +0800
From: kbuild test robot <lkp@intel.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dell_rbu: make firmware payload memory uncachable
Message-ID: <201803231032.7K7nqUGl%fengguang.wu@intel.com>
References: <40006403-999f-fde5-316a-63e9a48ce11c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <40006403-999f-fde5-316a-63e9a48ce11c@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stuart,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc6 next-20180322]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stuart-Hayes/dell_rbu-make-firmware-payload-memory-uncachable/20180323-094405
config: i386-randconfig-a0-201811 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/firmware/dell_rbu.c: In function 'create_packet':
>> drivers/firmware/dell_rbu.c:187:3: error: implicit declaration of function 'set_memory_uc' [-Werror=implicit-function-declaration]
      set_memory_uc(packet_data_temp_buf, 1 << (ordernum));
      ^
   drivers/firmware/dell_rbu.c: In function 'packet_empty_list':
>> drivers/firmware/dell_rbu.c:357:3: error: implicit declaration of function 'set_memory_wb' [-Werror=implicit-function-declaration]
      set_memory_wb(newpacket->data, (1 << newpacket->ordernum));
      ^
   cc1: some warnings being treated as errors

vim +/set_memory_uc +187 drivers/firmware/dell_rbu.c

   101	
   102	static int create_packet(void *data, size_t length)
   103	{
   104		struct packet_data *newpacket;
   105		int ordernum = 0;
   106		int retval = 0;
   107		unsigned int packet_array_size = 0;
   108		void **invalid_addr_packet_array = NULL;
   109		void *packet_data_temp_buf = NULL;
   110		unsigned int idx = 0;
   111	
   112		pr_debug("create_packet: entry \n");
   113	
   114		if (!rbu_data.packetsize) {
   115			pr_debug("create_packet: packetsize not specified\n");
   116			retval = -EINVAL;
   117			goto out_noalloc;
   118		}
   119	
   120		spin_unlock(&rbu_data.lock);
   121	
   122		newpacket = kzalloc(sizeof (struct packet_data), GFP_KERNEL);
   123	
   124		if (!newpacket) {
   125			printk(KERN_WARNING
   126				"dell_rbu:%s: failed to allocate new "
   127				"packet\n", __func__);
   128			retval = -ENOMEM;
   129			spin_lock(&rbu_data.lock);
   130			goto out_noalloc;
   131		}
   132	
   133		ordernum = get_order(length);
   134	
   135		/*
   136		 * BIOS errata mean we cannot allocate packets below 1MB or they will
   137		 * be overwritten by BIOS.
   138		 *
   139		 * array to temporarily hold packets
   140		 * that are below the allocation floor
   141		 *
   142		 * NOTE: very simplistic because we only need the floor to be at 1MB
   143		 *       due to BIOS errata. This shouldn't be used for higher floors
   144		 *       or you will run out of mem trying to allocate the array.
   145		 */
   146		packet_array_size = max(
   147		       		(unsigned int)(allocation_floor / rbu_data.packetsize),
   148				(unsigned int)1);
   149		invalid_addr_packet_array = kzalloc(packet_array_size * sizeof(void*),
   150							GFP_KERNEL);
   151	
   152		if (!invalid_addr_packet_array) {
   153			printk(KERN_WARNING
   154				"dell_rbu:%s: failed to allocate "
   155				"invalid_addr_packet_array \n",
   156				__func__);
   157			retval = -ENOMEM;
   158			spin_lock(&rbu_data.lock);
   159			goto out_alloc_packet;
   160		}
   161	
   162		while (!packet_data_temp_buf) {
   163			packet_data_temp_buf = (unsigned char *)
   164				__get_free_pages(GFP_KERNEL, ordernum);
   165			if (!packet_data_temp_buf) {
   166				printk(KERN_WARNING
   167					"dell_rbu:%s: failed to allocate new "
   168					"packet\n", __func__);
   169				retval = -ENOMEM;
   170				spin_lock(&rbu_data.lock);
   171				goto out_alloc_packet_array;
   172			}
   173	
   174			if ((unsigned long)virt_to_phys(packet_data_temp_buf)
   175					< allocation_floor) {
   176				pr_debug("packet 0x%lx below floor at 0x%lx.\n",
   177						(unsigned long)virt_to_phys(
   178							packet_data_temp_buf),
   179						allocation_floor);
   180				invalid_addr_packet_array[idx++] = packet_data_temp_buf;
   181				packet_data_temp_buf = NULL;
   182			}
   183			/*
   184			 * set to uncachable or it may never get written back before
   185			 * reboot
   186			 */
 > 187			set_memory_uc(packet_data_temp_buf, 1 << (ordernum));
   188		}
   189		spin_lock(&rbu_data.lock);
   190	
   191		newpacket->data = packet_data_temp_buf;
   192	
   193		pr_debug("create_packet: newpacket at physical addr %lx\n",
   194			(unsigned long)virt_to_phys(newpacket->data));
   195	
   196		/* packets may not have fixed size */
   197		newpacket->length = length;
   198		newpacket->ordernum = ordernum;
   199		++rbu_data.num_packets;
   200	
   201		/* initialize the newly created packet headers */
   202		INIT_LIST_HEAD(&newpacket->list);
   203		list_add_tail(&newpacket->list, &packet_data_head.list);
   204	
   205		memcpy(newpacket->data, data, length);
   206	
   207		pr_debug("create_packet: exit \n");
   208	
   209	out_alloc_packet_array:
   210		/* always free packet array */
   211		for (;idx>0;idx--) {
   212			pr_debug("freeing unused packet below floor 0x%lx.\n",
   213				(unsigned long)virt_to_phys(
   214					invalid_addr_packet_array[idx-1]));
   215			free_pages((unsigned long)invalid_addr_packet_array[idx-1],
   216				ordernum);
   217		}
   218		kfree(invalid_addr_packet_array);
   219	
   220	out_alloc_packet:
   221		/* if error, free data */
   222		if (retval)
   223			kfree(newpacket);
   224	
   225	out_noalloc:
   226		return retval;
   227	}
   228	
   229	static int packetize_data(const u8 *data, size_t length)
   230	{
   231		int rc = 0;
   232		int done = 0;
   233		int packet_length;
   234		u8 *temp;
   235		u8 *end = (u8 *) data + length;
   236		pr_debug("packetize_data: data length %zd\n", length);
   237		if (!rbu_data.packetsize) {
   238			printk(KERN_WARNING
   239				"dell_rbu: packetsize not specified\n");
   240			return -EIO;
   241		}
   242	
   243		temp = (u8 *) data;
   244	
   245		/* packetize the hunk */
   246		while (!done) {
   247			if ((temp + rbu_data.packetsize) < end)
   248				packet_length = rbu_data.packetsize;
   249			else {
   250				/* this is the last packet */
   251				packet_length = end - temp;
   252				done = 1;
   253			}
   254	
   255			if ((rc = create_packet(temp, packet_length)))
   256				return rc;
   257	
   258			pr_debug("%p:%td\n", temp, (end - temp));
   259			temp += packet_length;
   260		}
   261	
   262		rbu_data.imagesize = length;
   263	
   264		return rc;
   265	}
   266	
   267	static int do_packet_read(char *data, struct list_head *ptemp_list,
   268		int length, int bytes_read, int *list_read_count)
   269	{
   270		void *ptemp_buf;
   271		struct packet_data *newpacket = NULL;
   272		int bytes_copied = 0;
   273		int j = 0;
   274	
   275		newpacket = list_entry(ptemp_list, struct packet_data, list);
   276		*list_read_count += newpacket->length;
   277	
   278		if (*list_read_count > bytes_read) {
   279			/* point to the start of unread data */
   280			j = newpacket->length - (*list_read_count - bytes_read);
   281			/* point to the offset in the packet buffer */
   282			ptemp_buf = (u8 *) newpacket->data + j;
   283			/*
   284			 * check if there is enough room in
   285			 * * the incoming buffer
   286			 */
   287			if (length > (*list_read_count - bytes_read))
   288				/*
   289				 * copy what ever is there in this
   290				 * packet and move on
   291				 */
   292				bytes_copied = (*list_read_count - bytes_read);
   293			else
   294				/* copy the remaining */
   295				bytes_copied = length;
   296			memcpy(data, ptemp_buf, bytes_copied);
   297		}
   298		return bytes_copied;
   299	}
   300	
   301	static int packet_read_list(char *data, size_t * pread_length)
   302	{
   303		struct list_head *ptemp_list;
   304		int temp_count = 0;
   305		int bytes_copied = 0;
   306		int bytes_read = 0;
   307		int remaining_bytes = 0;
   308		char *pdest = data;
   309	
   310		/* check if we have any packets */
   311		if (0 == rbu_data.num_packets)
   312			return -ENOMEM;
   313	
   314		remaining_bytes = *pread_length;
   315		bytes_read = rbu_data.packet_read_count;
   316	
   317		ptemp_list = (&packet_data_head.list)->next;
   318		while (!list_empty(ptemp_list)) {
   319			bytes_copied = do_packet_read(pdest, ptemp_list,
   320				remaining_bytes, bytes_read, &temp_count);
   321			remaining_bytes -= bytes_copied;
   322			bytes_read += bytes_copied;
   323			pdest += bytes_copied;
   324			/*
   325			 * check if we reached end of buffer before reaching the
   326			 * last packet
   327			 */
   328			if (remaining_bytes == 0)
   329				break;
   330	
   331			ptemp_list = ptemp_list->next;
   332		}
   333		/*finally set the bytes read */
   334		*pread_length = bytes_read - rbu_data.packet_read_count;
   335		rbu_data.packet_read_count = bytes_read;
   336		return 0;
   337	}
   338	
   339	static void packet_empty_list(void)
   340	{
   341		struct list_head *ptemp_list;
   342		struct list_head *pnext_list;
   343		struct packet_data *newpacket;
   344	
   345		ptemp_list = (&packet_data_head.list)->next;
   346		while (!list_empty(ptemp_list)) {
   347			newpacket =
   348				list_entry(ptemp_list, struct packet_data, list);
   349			pnext_list = ptemp_list->next;
   350			list_del(ptemp_list);
   351			ptemp_list = pnext_list;
   352			/*
   353			 * zero out the RBU packet memory before freeing
   354			 * to make sure there are no stale RBU packets left in memory
   355			 */
   356			memset(newpacket->data, 0, rbu_data.packetsize);
 > 357			set_memory_wb(newpacket->data, (1 << newpacket->ordernum));
   358			free_pages((unsigned long) newpacket->data,
   359				newpacket->ordernum);
   360			kfree(newpacket);
   361		}
   362		rbu_data.packet_read_count = 0;
   363		rbu_data.num_packets = 0;
   364		rbu_data.imagesize = 0;
   365	}
   366	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k+w/mQv8wyuph6w0
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k+w/mQv8wyuph6w0--
