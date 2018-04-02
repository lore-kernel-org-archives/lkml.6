Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx4/E9mOYn/w6A0bJq/MvjgQA0pEMynqAcd4jrFAjenPyXPvZaf9pM0jP8LoA91tPMll4lgcH
ARC-Seal: i=1; a=rsa-sha256; t=1522676683; cv=none;
        d=google.com; s=arc-20160816;
        b=Fvmbl4n2tjeowQO9M3W6ca6jtbP7E0PYhi0HRS6E4EbQ+f4pzsvdk6hi+qbWcgIW4O
         idwDvTABDDytcqyITvYZXPw4043LsjKgQuHVf3lGrgCej7Det8evDvrh7oVjZoI6yxaO
         LBwfGGmW40C+RrTnMroecT6JpGG3oYS79QOi16ZYdjDqx2SympFHwgOv0B3BGe6OCXNp
         L68SbrdQgFy65NhFsnENRKk/kdnvZ3PVd+/mM0TNTz48eKwb/BZLX0k7PsO3LwW/yden
         QHqFSsdhox8cOfILbd/xtnzRRH6Ebh7l8Tv9A1KlFMcXdOHBpHZm4NY4gFQyEUatyeEC
         SX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=nNY+LxJL+R4CeyvFVo9uugpSKQ4Xitu1U2vIGK1ELv4=;
        b=LUgwEYVVgIJqVcemChEwPqHV53NxtrTmTNUb1v4EObN0+7kMlI/twzkmEjp+absxja
         wUL1V2smevN1U0Wu+D8LDW+Ic2NloKgfjGPhVfeu+4RhpmRZUO22ubtOMAykayn9Orw4
         gYUUDyo6oWLd2tmVrKuA7JNK/TVRv7osyp+OBTCXHaP6rAb7O0vrEaG/qwiiC+uQhWfo
         UToLTJt4iHDCKPXlasBmPXq7aAb7z2Pe2Cd1Li2pADiqh3UpufSo+vLGuy9w1KftFLbd
         38k6a5wtiiyJbH0UxXCjevyt0exjI7PTlXirbwVoKtzaKduEkmWcXKoT/myOkikrHdQr
         ayKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=S04YcfEm;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=S04YcfEm;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Mon, 2 Apr 2018 15:44:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>, gregkh <gregkh@linuxfoundation.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180402134441.GB10520@lunn.ch>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <20180328162811.GB15827@lunn.ch>
 <HE1PR04MB32127E14E0953910746A6363E0A60@HE1PR04MB3212.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR04MB32127E14E0953910746A6363E0A60@HE1PR04MB3212.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596642226106632523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ioana

> The commands listed above are for creating/destroying DPAA2 objects
> in Management Complex and not for runtime configuration where
> standard userspace tools are used.

Please can you explain why this is not just plumbing inside a
switchdev driver?

The hardware has a number of physical ports. So on probe, i would
expect it to create a DPMAC, DPNI, and DPIO for each port, and a linux
netdev. From then on, standard tools are all that are needed. The
switchdev driver can create a l2 switch object when the user uses the
ip link add name br0 type bridge. It can then connect the switch
object to the DPNI when the user adds an interface to the switch, etc.

       Andrew
